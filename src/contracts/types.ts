export interface Venue {
  id: string;
  name: string;
  district: District;
  tags: VenueTag[];
  ratings: VenueRatings;
  hasLiveVibe: boolean;
  description?: string;
  address?: string;
}

export interface VenueRatings {
  music: number; // 0-100
  vibe: number;
  crowd: number;
  safety: number;
}

export interface Review {
  id: string;
  venueId: string;
  authorName?: string;
  isAnonymous: boolean;
  ratings: VenueRatings;
  comment: string;
  queueTime?: number; // minutes
  createdAt: Date;
  photoUrl?: string;
}

export interface VibeSample {
  id: string;
  venueId: string;
  timestamp: Date;
  doorStrictness: number; // 0-100
  queueEstimate: number; // minutes
  musicIntensity: number; // 0-100
  crowdHeat: number; // 0-100
  suggestion: string;
}

export interface VibeSummary {
  venueId: string;
  doorStrictness: number;
  queueEstimate: number;
  musicIntensity: number;
  crowdHeat: number;
  suggestion: string;
  lastUpdated: Date;
  bestWindow?: string;
}


export interface ReviewInput {
  venueId: string;
  userId?: string; // Add userId for database insertion
  ratings: VenueRatings;
  comment: string;
  queueTime?: number;
  isAnonymous: boolean;
  photoUrl?: string;
}

export type District = 
  | 'Kreuzberg'
  | 'Friedrichshain'
  | 'Neukölln'
  | 'Mitte'
  | 'Prenzlauer Berg'
  | 'Wedding';

export type VenueTag = 
  | 'techno'
  | 'house'
  | 'disco'
  | 'punk'
  | 'underground'
  | 'cocktails'
  | 'beer-garden'
  | 'rooftop'
  | 'traditional'
  | 'upscale'
  | 'historic'
  | 'classic'
  | 'queer-friendly'
  | 'cash-only'
  | 'outdoor'
  | 'smoke-room'
  | 'late-night'
  | 'tourist-free';

