# RAVEN 🎭
*"NO CARE, WE DARE, LAID BARE"*

**RAVEN** is a Berlin nightlife discovery app focused on authentic, unfiltered reviews of clubs and bars. Built for the Berlin party scene with real-time data and anonymous feedback.

## 📱 About RAVEN

RAVEN exists for one purpose: **honest reviews of Berlin's nightlife**. No corporate sponsorships, no promotional content—just real experiences from real people navigating Berlin's legendary club and bar scene.

### Core Philosophy
- **Anonymous Reviews**: Share honest experiences without judgment
- **Real-time Club Data**: Live information from Supabase database
- **Community-Driven**: By night owls, for night owls
- **No Commercial Influence**: Pure, unfiltered feedback

## 🚀 Tech Stack

### Frontend Framework
- **React 18.3+** - Modern component-based architecture
- **TypeScript** - Type-safe development
- **Vite** - Lightning-fast build tool and dev server

### Routing & Animations
- **React Router 7.8+** - Client-side routing
- **Framer Motion 12.23+** - Smooth page transitions and animations

### Styling & UI
- **Tailwind CSS 3.4+** - Utility-first CSS framework
- **Custom CSS Variables** - Berlin-themed dark color palette
- **Google Fonts** - Space Grotesk, Inter, Sora typography

### Backend & Data
- **Supabase** - PostgreSQL database for clubs and user authentication
- **Custom Services Layer** - API abstraction for different data sources

### Development Tools
- **ESLint** - Code linting and quality
- **TypeScript ESLint** - TypeScript-specific linting
- **PostCSS** - CSS processing and optimization

## 🌃 Core Features

### 🏠 Landing Page (`/`)
**The main entry point with dynamic animations and Berlin vibe**
- **Immersive Branding** - "NO CARE, WE DARE, LAID BARE" philosophy display
- **WordStreamReviews** - Multilingual floating review fragments in 8+ languages (EN, DE, ES, FR, ZH, RU, IT, HI, AR, TR)
- **Interactive 3D Cards** - Rotated card layouts with dynamic green smoke animations
- **Two Main Actions**:
  - **CLUBS Button** → Glitch-effect animated button to `/clubs`
  - **BARS Button** → Animated hover-fill effect button to `/bars`
- **Dynamic Stats** - Real-time club count from Supabase database

### 🎭 Clubs (`/clubs`, `/clubs/:id`)
**Real-time database-driven club discovery**
- **Data Source**: Supabase PostgreSQL database
- **Features**:
  - Real-time club information from database
  - Advanced filtering by district, construction features, payment methods
  - Live vibe tracking and atmosphere updates
  - Detailed club profiles with comprehensive information
  - Rating system: Music, Vibe, Crowd, Safety (0-100 scale)
- **Database Tables Used**:
  - `clubs` - Main club information
  - `districts` - Berlin district data
  - `club_ratings` - Venue rating aggregates
  - `club_themes` - Venue categorization
  - `club_tonight_vibe` - Real-time venue status

### 🍺 Bars (`/bars`, `/bars/:id`)
**Curated bar collection with mock data**
- **Data Source**: Local mock data (`src/data/bars.ts`)
- **Features**:
  - Handpicked Berlin bar establishments
  - Tag-based filtering (cocktails, beer-garden, rooftop, etc.)
  - District-based filtering
  - Rating display and venue information

### 📝 Review System (`/submit`)
**Anonymous review submission with authentication flow**
- **Authentication Required** - Supabase Auth integration with user-friendly login prompts
- **Data Integration**: Works with Supabase for clubs (`club_reviews` table)
- **Features**:
  - Anonymous review submission with user privacy protection
  - Multi-category sliding ratings (Music, Vibe, Crowd, Safety) with 0-100 scale
  - Custom slider components with Berlin-themed styling
  - Real-time database updates for club reviews
  - Optimistic UI updates with immediate feedback
  - Custom "Spill" button with rotating icon animation
  - 500-character comment limit with real-time counter

### 👤 User Authentication (`/profile`)
**Supabase-powered user system**
- **Features**:
  - User login/signup with Supabase Auth
  - Profile management
  - Authentication state management
  - Secure session handling

## 🏗️ Architecture

### Navigation Structure
The app has a simple 4-tab navigation:
```
Bottom Navigation:
├── CORE (/)           → Landing page
├── CLUBS (/clubs)     → Club discovery (Supabase data)
├── BARS (/bars)       → Bar discovery (mock data)  
└── ID (/profile)      → User authentication
```

### Data Architecture

#### Real Database Integration (Clubs)
```typescript
// Clubs use live Supabase data
const clubsService = {
  // Connects to PostgreSQL tables:
  // - clubs (main venue info)
  // - districts (Berlin areas)  
  // - club_ratings (aggregated ratings)
  // - club_themes (categorization)
  // - club_tonight_vibe (real-time status)
}
```

#### Mock Data (Bars)
```typescript
// Bars use local mock data for development
const barsService = {
  // Uses static data from src/data/bars.ts
  // Simulates API delays with setTimeout
}
```

### Project Structure (Actual Usage)
```
RAVEN/
├── src/
│   ├── components/
│   │   ├── ui/                    # Base UI components
│   │   ├── RavenBottomNav.tsx     # Main 4-tab navigation
│   │   ├── RatingBar.tsx          # Venue rating display
│   │   └── WordStreamReviews.tsx  # Animated review stream
│   ├── routes/                    # Page components
│   │   ├── Landing.tsx            # Main homepage (/)
│   │   ├── Clubs.tsx              # Club listing (/clubs)  
│   │   ├── ClubDetail.tsx         # Club details (/clubs/:id)
│   │   ├── Bars.tsx               # Bar listing (/bars)
│   │   ├── BarDetail.tsx          # Bar details (/bars/:id)
│   │   ├── Profile.tsx            # User auth (/profile)
│   │   └── SubmitReview.tsx       # Review form (/submit)
│   ├── services/                  # Data layer
│   │   ├── clubsService.ts        # ✅ Supabase integration
│   │   ├── barsService.ts         # ✅ Mock data service  
│   │   ├── reviewsService.ts      # ✅ Supabase reviews
│   │   └── [others]               # 🔸 Additional services
│   ├── data/                      # Static data
│   │   ├── bars.ts                # ✅ Bar mock data
│   │   └── [others]               # 🔸 Additional mock data
│   ├── lib/
│   │   └── supabase.ts            # ✅ Database client
│   └── contracts/
│       └── types.ts               # ✅ TypeScript definitions
```

## 🎨 Design System

### Berlin-Themed Color Palette
```css
:root {
  --berlin-black: #0B0B0B;  /* Primary dark background */
  --carbon: #101214;        /* Secondary background */
  --ink: #EDEDED;          /* Primary text */
  --ash: #9CA3AF;          /* Secondary text */
  --blood: #D0021B;        /* Accent/error color */
  --raven: #8ACE00;        /* Brand green accent */
}
```

### Typography System
- **Space Grotesk** - Headers and brand elements
- **Inter** - Body text and UI elements  
- **Sora** - Special buttons and accents

### Visual Effects & Animations
- **Scanline Animation** - CRT screen effect with moving green light lines
- **Glitch Button Effects** - Cyberpunk-inspired CLUBS button with text clipping and shadow effects
- **3D Card Transforms** - Perspective rotations (rotateZ, rotateX, rotateY) with depth shadows
- **Floating Smoke Animations** - Organic floating green orbs with blur effects and physics-like movement
- **Bars Button Animation** - Skewed fill effect with dual-color gradient transitions
- **WordStream Animation** - Physics-based floating text with multilingual content
- **Custom Navigation** - Sliding selection indicator with backdrop blur
- **Framer Motion** - Page transitions and component animations
- **Dark Theme** - Consistent Berlin nightlife aesthetic with custom CSS variables

## ⚙️ Setup & Configuration

### Environment Variables
Create `.env` file:
```env
# Supabase Configuration (required for clubs functionality)
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Database Setup (Supabase)
Required for clubs functionality:

#### Core Tables
1. **clubs** - Main club venue information
2. **districts** - Berlin district data  
3. **club_ratings** - Rating aggregates (music, vibe, crowd, safety)
4. **club_themes** - Theme/genre categorization
5. **club_reviews** - User-submitted reviews
6. **club_tonight_vibe** - Real-time venue status
7. **club_locations** - Address information

#### Authentication Tables
- Supabase handles user authentication tables automatically

### Development Setup

#### Prerequisites
- **Node.js** 18+
- **npm** (version in package-lock.json)
- **Supabase account** (for full clubs functionality)

#### Installation
```bash
# Clone and install
git clone <repository-url>
cd RAVEN
npm install

# Configure environment  
# Create .env file with your Supabase credentials
echo "VITE_SUPABASE_URL=your_supabase_project_url" > .env
echo "VITE_SUPABASE_ANON_KEY=your_supabase_anon_key" >> .env

# Start development
npm run dev
```

#### Available Scripts
```bash
npm run dev            # Development server (http://localhost:5173)
npm run dev:live       # Netlify dev with live preview
npm run build          # Production build to /dist
npm run preview        # Preview production build
npm run lint           # ESLint code linting
```

#### Development Features
- **Hot Module Replacement** - Instant updates during development
- **TypeScript Support** - Full type checking and IntelliSense
- **Path Aliasing** - Clean import paths with Vite configuration
- **Development Proxy** - Netlify dev environment simulation

## 🚀 Deployment

### Netlify Configuration
The project is configured for Netlify deployment with:
```toml
[build]
  command = "npm run build"
  functions = "netlify/functions"
  publish = "dist"

[dev]
  command = "npm run dev"
  targetPort = 5173
  port = 8888
  framework = "#custom"
```

### Deployment Steps
1. **Build Command**: `npm run build` generates production files in `/dist`
2. **Environment Variables**: Configure Supabase credentials in Netlify dashboard
3. **SPA Routing**: Ensure proper redirects for client-side routing
4. **Functions**: Optional serverless functions in `/netlify/functions`

## 🔧 Development Notes

### Data Sources by Feature
- **✅ Clubs**: Supabase PostgreSQL (real-time data)
- **✅ Bars**: Mock data (`src/data/bars.ts`)
- **✅ User Auth**: Supabase Auth
- **✅ Reviews**: Supabase (clubs only via `club_reviews` table)

### Code Architecture Patterns
- **TypeScript Strict Mode** - Enhanced type safety with comprehensive interfaces
- **Component-Based Architecture** - Modular React components with clear separation
- **Service Layer Pattern** - Data access abstracted through service classes
- **Mobile-First Design** - Responsive layouts optimized for mobile experience
- **Custom Hook Pattern** - Reusable state logic (useEffect, useState)
- **Error Boundary Pattern** - Graceful error handling and loading states

### Performance Features
- **Vite Build System** - Fast development server and optimized production builds
- **Code Splitting** - Dynamic imports for routes (implicit with React Router)
- **Tailwind CSS Purging** - Removes unused CSS classes automatically
- **Image Optimization** - WebP images and responsive loading
- **Bundle Analysis** - Build size optimization with dependency analysis
- **Touch Action Optimization** - Eliminates 300ms mobile tap delay with `touch-action: manipulation`

## 🛣️ Route Map

### Primary Routes (in navigation)
```
/           → Landing page with CLUBS/BARS buttons
/clubs      → Club discovery interface (Supabase data)
/bars       → Bar discovery interface (mock data)  
/profile    → User authentication system
```

### Secondary Routes (accessible via links)
```
/clubs/:id  → Individual club detail pages
/bars/:id   → Individual bar detail pages  
/submit     → Review submission (from venue detail pages)
```

### Authentication Flow
```
/profile → Login/Signup → Authenticated state
```

## 📱 User Experience

### Navigation Flow
1. **Landing** → Choose CLUBS or BARS
2. **Discovery** → Browse filtered venues  
3. **Details** → View venue information
4. **Review** → Submit anonymous feedback
5. **Profile** → Manage authentication

### Key Features
- **Real-time club data** from Supabase
- **Anonymous review system**
- **Advanced filtering** by district and features
- **Mobile-optimized interface**
- **Dark theme** matching Berlin nightlife aesthetic

## 🤝 Contributing

### Development Principles
1. **Mobile-First** - Optimize for mobile experience
2. **Performance** - Fast loading and smooth interactions
3. **Type Safety** - Comprehensive TypeScript usage
4. **Data Accuracy** - Real database integration where needed
5. **User Privacy** - Anonymous-friendly features

### Code Guidelines
- Use TypeScript for all components
- Follow existing naming conventions  
- Ensure mobile responsiveness
- Test both Supabase and mock data flows
- Maintain consistent styling with design system

## 📄 License

This project is private and proprietary.

---

**RAVEN** - *Authentic Berlin Nightlife Discovery* 🌃

*Built for the Berlin club scene with real data and honest reviews*

---

*📝 Last updated: December 2024 | Based on actual code analysis*