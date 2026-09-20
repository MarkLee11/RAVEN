const axios = require('axios');
const fs = require('fs').promises;
const path = require('path');

// API Configuration
const GOOGLE_PLACES_API_KEY = 'AIzaSyA_sTFlc6UHUxK_iwbEj3znq3Tx5PQu-VA';
const FOURSQUARE_API_KEY = 'fsq3AIbXTheO5dyuqBSBtZxKhURNMvyVuQbbDDJUL4fVxr8=';

// Berlin coordinates and search radius
const BERLIN_CENTER = {
  lat: 52.5200,
  lng: 13.4050
};
const SEARCH_RADIUS = 25000; // 25km radius to cover Berlin

// Bar types to search for
const BAR_TYPES = [
  'bar',
  'night_club',
  'liquor_store',
  'restaurant' // Some bars are categorized as restaurants
];

const BAR_KEYWORDS = [
  'bar',
  'pub',
  'cocktail bar',
  'wine bar',
  'beer garden',
  'biergarten',
  'lounge',
  'tavern',
  'brewery',
  'craft beer',
  'sports bar',
  'rooftop bar'
];

// Rate limiting configuration
const RATE_LIMITS = {
  google: {
    requestsPerSecond: 10,
    dailyLimit: 1000
  },
  foursquare: {
    requestsPerSecond: 5,
    dailyLimit: 950 // Free tier limit
  }
};

// Data storage
let collectedBars = [];
let processedPlaceIds = new Set();
let requestCounts = {
  google: 0,
  foursquare: 0
};

// Logging utility
function log(message, level = 'INFO') {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] [${level}] ${message}`);
}

// Rate limiting utility
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

class RateLimiter {
  constructor(requestsPerSecond) {
    this.requestsPerSecond = requestsPerSecond;
    this.lastRequestTime = 0;
  }

  async waitIfNeeded() {
    const now = Date.now();
    const timeSinceLastRequest = now - this.lastRequestTime;
    const minInterval = 1000 / this.requestsPerSecond;
    
    if (timeSinceLastRequest < minInterval) {
      const waitTime = minInterval - timeSinceLastRequest;
      await sleep(waitTime);
    }
    
    this.lastRequestTime = Date.now();
  }
}

const googleRateLimiter = new RateLimiter(RATE_LIMITS.google.requestsPerSecond);
const foursquareRateLimiter = new RateLimiter(RATE_LIMITS.foursquare.requestsPerSecond);

// Google Places API functions
async function searchGooglePlaces(keyword, pageToken = null) {
  await googleRateLimiter.waitIfNeeded();
  
  try {
    const baseUrl = 'https://maps.googleapis.com/maps/api/place/textsearch/json';
    const params = {
      query: `${keyword} in Berlin`,
      location: `${BERLIN_CENTER.lat},${BERLIN_CENTER.lng}`,
      radius: SEARCH_RADIUS,
      key: GOOGLE_PLACES_API_KEY
    };
    
    if (pageToken) {
      params.pagetoken = pageToken;
    }
    
    const response = await axios.get(baseUrl, { params });
    requestCounts.google++;
    
    if (response.data.status !== 'OK' && response.data.status !== 'ZERO_RESULTS') {
      throw new Error(`Google Places API error: ${response.data.status}`);
    }
    
    return response.data;
  } catch (error) {
    log(`Error searching Google Places: ${error.message}`, 'ERROR');
    throw error;
  }
}

async function getGooglePlaceDetails(placeId) {
  await googleRateLimiter.waitIfNeeded();
  
  try {
    const baseUrl = 'https://maps.googleapis.com/maps/api/place/details/json';
    const params = {
      place_id: placeId,
      fields: 'name,formatted_address,geometry,formatted_phone_number,website,opening_hours,rating,user_ratings_total,reviews,photos,types,price_level',
      key: GOOGLE_PLACES_API_KEY
    };
    
    const response = await axios.get(baseUrl, { params });
    requestCounts.google++;
    
    if (response.data.status !== 'OK') {
      throw new Error(`Google Place Details API error: ${response.data.status}`);
    }
    
    return response.data.result;
  } catch (error) {
    log(`Error getting Google Place details: ${error.message}`, 'ERROR');
    throw error;
  }
}

// Foursquare API functions
async function searchFoursquarePlaces(query) {
  await foursquareRateLimiter.waitIfNeeded();
  
  try {
    const baseUrl = 'https://api.foursquare.com/v3/places/search';
    const params = {
      query: query,
      near: 'Berlin,Germany',
      radius: SEARCH_RADIUS,
      categories: '13003,13004,13005,13032,13033,13034,13035,13036,13037,13038,13039', // Various bar/nightlife categories
      limit: 50
    };
    
    const response = await axios.get(baseUrl, {
      params,
      headers: {
        'Authorization': FOURSQUARE_API_KEY,
        'Accept': 'application/json'
      }
    });
    
    requestCounts.foursquare++;
    return response.data.results || [];
  } catch (error) {
    log(`Error searching Foursquare: ${error.message}`, 'ERROR');
    throw error;
  }
}

async function getFoursquareDetails(fsqId) {
  await foursquareRateLimiter.waitIfNeeded();
  
  try {
    const baseUrl = `https://api.foursquare.com/v3/places/${fsqId}`;
    const params = {
      fields: 'name,location,contact,website,hours,rating,stats,photos,categories,price,description'
    };
    
    const response = await axios.get(baseUrl, {
      params,
      headers: {
        'Authorization': FOURSQUARE_API_KEY,
        'Accept': 'application/json'
      }
    });
    
    requestCounts.foursquare++;
    return response.data;
  } catch (error) {
    log(`Error getting Foursquare details: ${error.message}`, 'ERROR');
    throw error;
  }
}

// Data processing functions
function normalizeBarData(googleData, foursquareData = null) {
  const bar = {
    id: googleData.place_id,
    name: googleData.name,
    address: googleData.formatted_address,
    latitude: googleData.geometry?.location?.lat,
    longitude: googleData.geometry?.location?.lng,
    phone: googleData.formatted_phone_number,
    website: googleData.website,
    rating: googleData.rating,
    total_ratings: googleData.user_ratings_total,
    price_level: googleData.price_level,
    types: googleData.types,
    opening_hours: googleData.opening_hours?.weekday_text,
    reviews: googleData.reviews?.slice(0, 5).map(review => ({
      author: review.author_name,
      rating: review.rating,
      text: review.text,
      time: review.time
    })),
    photos: googleData.photos?.slice(0, 3).map(photo => ({
      reference: photo.photo_reference,
      width: photo.width,
      height: photo.height
    })),
    source: 'google',
    scraped_at: new Date().toISOString()
  };
  
  // Merge Foursquare data if available
  if (foursquareData) {
    bar.foursquare_data = {
      id: foursquareData.fsq_id,
      categories: foursquareData.categories,
      description: foursquareData.description,
      stats: foursquareData.stats,
      price: foursquareData.price
    };
  }
  
  return bar;
}

function isValidBar(place) {
  const name = place.name?.toLowerCase() || '';
  const types = place.types || [];
  
  // Check if it's likely a bar/pub/nightlife venue
  const barKeywords = ['bar', 'pub', 'tavern', 'lounge', 'brewery', 'biergarten', 'cocktail', 'wine'];
  const hasBarKeyword = barKeywords.some(keyword => name.includes(keyword));
  
  const barTypes = ['bar', 'night_club', 'liquor_store'];
  const hasBarType = types.some(type => barTypes.includes(type));
  
  // Exclude obvious non-bars
  const excludeKeywords = ['hotel', 'restaurant', 'cafe', 'shop', 'store', 'market', 'bank', 'hospital'];
  const isExcluded = excludeKeywords.some(keyword => name.includes(keyword)) && !hasBarKeyword;
  
  return (hasBarKeyword || hasBarType) && !isExcluded;
}

// Main scraping functions
async function scrapeGooglePlaces() {
  log('Starting Google Places scraping...');
  
  for (const keyword of BAR_KEYWORDS) {
    log(`Searching for: ${keyword}`);
    
    let pageToken = null;
    let pageCount = 0;
    
    do {
      try {
        const searchResults = await searchGooglePlaces(keyword, pageToken);
        const places = searchResults.results || [];
        
        log(`Found ${places.length} places for keyword: ${keyword} (page ${pageCount + 1})`);
        
        for (const place of places) {
          if (processedPlaceIds.has(place.place_id)) {
            continue; // Skip duplicates
          }
          
          if (!isValidBar(place)) {
            continue; // Skip non-bars
          }
          
          try {
            const details = await getGooglePlaceDetails(place.place_id);
            const normalizedBar = normalizeBarData(details);
            
            collectedBars.push(normalizedBar);
            processedPlaceIds.add(place.place_id);
            
            log(`Collected: ${normalizedBar.name} (${collectedBars.length} total)`);
            
            // Save progress every 10 bars
            if (collectedBars.length % 10 === 0) {
              await saveProgress();
            }
            
          } catch (error) {
            log(`Error processing place ${place.name}: ${error.message}`, 'ERROR');
          }
        }
        
        pageToken = searchResults.next_page_token;
        pageCount++;
        
        // Wait before next page (Google requires delay for next_page_token)
        if (pageToken) {
          await sleep(2000);
        }
        
      } catch (error) {
        log(`Error searching for ${keyword}: ${error.message}`, 'ERROR');
        break;
      }
    } while (pageToken && pageCount < 3); // Limit to 3 pages per keyword
  }
  
  log(`Google Places scraping completed. Collected ${collectedBars.length} bars.`);
}

async function supplementWithFoursquare() {
  log('Supplementing data with Foursquare...');
  
  // Search for additional bars on Foursquare
  for (const keyword of BAR_KEYWORDS.slice(0, 5)) { // Limit keywords due to API limits
    try {
      const places = await searchFoursquarePlaces(keyword);
      log(`Found ${places.length} Foursquare places for: ${keyword}`);
      
      for (const place of places) {
        // Check if we already have this place (by name and approximate location)
        const existing = collectedBars.find(bar => 
          bar.name.toLowerCase() === place.name.toLowerCase() &&
          Math.abs(bar.latitude - place.geocodes?.main?.latitude) < 0.001 &&
          Math.abs(bar.longitude - place.geocodes?.main?.longitude) < 0.001
        );
        
        if (existing) {
          // Supplement existing data
          try {
            const details = await getFoursquareDetails(place.fsq_id);
            existing.foursquare_data = {
              id: details.fsq_id,
              categories: details.categories,
              description: details.description,
              stats: details.stats,
              price: details.price
            };
            log(`Supplemented: ${existing.name}`);
          } catch (error) {
            log(`Error getting Foursquare details for ${place.name}: ${error.message}`, 'ERROR');
          }
        }
      }
    } catch (error) {
      log(`Error searching Foursquare for ${keyword}: ${error.message}`, 'ERROR');
    }
  }
  
  log('Foursquare supplementation completed.');
}

// Data export functions
async function saveProgress() {
  try {
    const progressFile = path.join(__dirname, 'berlin-bars-progress.json');
    await fs.writeFile(progressFile, JSON.stringify({
      bars: collectedBars,
      processedPlaceIds: Array.from(processedPlaceIds),
      requestCounts,
      lastUpdated: new Date().toISOString()
    }, null, 2));
    
    log(`Progress saved: ${collectedBars.length} bars`);
  } catch (error) {
    log(`Error saving progress: ${error.message}`, 'ERROR');
  }
}

async function exportToJSON() {
  try {
    const outputFile = path.join(__dirname, 'berlin-bars-data.json');
    await fs.writeFile(outputFile, JSON.stringify(collectedBars, null, 2));
    log(`Data exported to JSON: ${outputFile}`);
  } catch (error) {
    log(`Error exporting to JSON: ${error.message}`, 'ERROR');
  }
}

async function exportToSQL() {
  try {
    let sql = `-- Berlin Bars Data Export\n-- Generated on ${new Date().toISOString()}\n-- Total bars: ${collectedBars.length}\n\n`;
    
    sql += `CREATE TABLE IF NOT EXISTS berlin_bars (\n`;
    sql += `  id VARCHAR(255) PRIMARY KEY,\n`;
    sql += `  name VARCHAR(255) NOT NULL,\n`;
    sql += `  address TEXT,\n`;
    sql += `  latitude DECIMAL(10, 8),\n`;
    sql += `  longitude DECIMAL(11, 8),\n`;
    sql += `  phone VARCHAR(50),\n`;
    sql += `  website TEXT,\n`;
    sql += `  rating DECIMAL(3, 2),\n`;
    sql += `  total_ratings INTEGER,\n`;
    sql += `  price_level INTEGER,\n`;
    sql += `  types TEXT,\n`;
    sql += `  opening_hours TEXT,\n`;
    sql += `  reviews TEXT,\n`;
    sql += `  photos TEXT,\n`;
    sql += `  foursquare_data TEXT,\n`;
    sql += `  scraped_at TIMESTAMP\n`;
    sql += `);\n\n`;
    
    for (const bar of collectedBars) {
      const values = [
        `'${bar.id.replace(/'/g, "''")}'`,
        `'${bar.name.replace(/'/g, "''")}'`,
        bar.address ? `'${bar.address.replace(/'/g, "''")}'` : 'NULL',
        bar.latitude || 'NULL',
        bar.longitude || 'NULL',
        bar.phone ? `'${bar.phone.replace(/'/g, "''")}'` : 'NULL',
        bar.website ? `'${bar.website.replace(/'/g, "''")}'` : 'NULL',
        bar.rating || 'NULL',
        bar.total_ratings || 'NULL',
        bar.price_level || 'NULL',
        bar.types ? `'${JSON.stringify(bar.types).replace(/'/g, "''")}'` : 'NULL',
        bar.opening_hours ? `'${JSON.stringify(bar.opening_hours).replace(/'/g, "''")}'` : 'NULL',
        bar.reviews ? `'${JSON.stringify(bar.reviews).replace(/'/g, "''")}'` : 'NULL',
        bar.photos ? `'${JSON.stringify(bar.photos).replace(/'/g, "''")}'` : 'NULL',
        bar.foursquare_data ? `'${JSON.stringify(bar.foursquare_data).replace(/'/g, "''")}'` : 'NULL',
        `'${bar.scraped_at}'`
      ];
      
      sql += `INSERT INTO berlin_bars VALUES (${values.join(', ')});\n`;
    }
    
    const outputFile = path.join(__dirname, 'berlin-bars-data.sql');
    await fs.writeFile(outputFile, sql);
    log(`Data exported to SQL: ${outputFile}`);
  } catch (error) {
    log(`Error exporting to SQL: ${error.message}`, 'ERROR');
  }
}

// Main execution function
async function main() {
  try {
    log('Starting Berlin bars data scraping...');
    log(`API Request Limits - Google: ${RATE_LIMITS.google.dailyLimit}, Foursquare: ${RATE_LIMITS.foursquare.dailyLimit}`);
    
    // Load previous progress if exists
    try {
      const progressFile = path.join(__dirname, 'berlin-bars-progress.json');
      const progressData = JSON.parse(await fs.readFile(progressFile, 'utf8'));
      collectedBars = progressData.bars || [];
      processedPlaceIds = new Set(progressData.processedPlaceIds || []);
      requestCounts = progressData.requestCounts || { google: 0, foursquare: 0 };
      log(`Loaded previous progress: ${collectedBars.length} bars`);
    } catch (error) {
      log('No previous progress found, starting fresh.');
    }
    
    // Scrape Google Places
    await scrapeGooglePlaces();
    
    // Supplement with Foursquare data
    await supplementWithFoursquare();
    
    // Export data
    await exportToJSON();
    await exportToSQL();
    
    // Final statistics
    log('\n=== SCRAPING COMPLETED ===');
    log(`Total bars collected: ${collectedBars.length}`);
    log(`Google API requests: ${requestCounts.google}`);
    log(`Foursquare API requests: ${requestCounts.foursquare}`);
    log(`Data exported to: berlin-bars-data.json and berlin-bars-data.sql`);
    
    // Show sample data
    if (collectedBars.length > 0) {
      log('\nSample bar data:');
      console.log(JSON.stringify(collectedBars[0], null, 2));
    }
    
  } catch (error) {
    log(`Fatal error: ${error.message}`, 'ERROR');
    process.exit(1);
  }
}

// Run the scraper
if (require.main === module) {
  main();
}

module.exports = {
  main,
  scrapeGooglePlaces,
  supplementWithFoursquare,
  exportToJSON,
  exportToSQL
};