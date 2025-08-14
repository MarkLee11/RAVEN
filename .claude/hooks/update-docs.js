#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function analyzeCodebase() {
  const analysis = {
    projectName: 'RAVEN',
    description: '',
    techStack: [],
    structure: {},
    features: [],
    routes: [],
    components: []
  };

  try {
    // Read package.json
    const packagePath = path.join(process.cwd(), 'package.json');
    if (fs.existsSync(packagePath)) {
      const pkg = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
      analysis.projectName = pkg.name || 'RAVEN';
      analysis.description = pkg.description || '';
      
      // Analyze tech stack from dependencies
      const deps = { ...pkg.dependencies, ...pkg.devDependencies };
      if (deps.react) analysis.techStack.push('React');
      if (deps.typescript) analysis.techStack.push('TypeScript');
      if (deps.vite) analysis.techStack.push('Vite');
      if (deps['react-router-dom']) analysis.techStack.push('React Router');
      if (deps['framer-motion']) analysis.techStack.push('Framer Motion');
      if (deps.tailwindcss) analysis.techStack.push('Tailwind CSS');
    }

    // Analyze src structure
    const srcPath = path.join(process.cwd(), 'src');
    if (fs.existsSync(srcPath)) {
      analysis.structure = analyzeFolderStructure(srcPath);
      
      // Analyze routes
      const routesPath = path.join(srcPath, 'routes');
      if (fs.existsSync(routesPath)) {
        analysis.routes = fs.readdirSync(routesPath)
          .filter(file => file.endsWith('.tsx'))
          .map(file => file.replace('.tsx', ''));
      }

      // Analyze components
      const componentsPath = path.join(srcPath, 'components');
      if (fs.existsSync(componentsPath)) {
        analysis.components = getAllFiles(componentsPath, '.tsx')
          .map(file => path.basename(file, '.tsx'));
      }

      // Extract features from App.tsx
      const appPath = path.join(srcPath, 'App.tsx');
      if (fs.existsSync(appPath)) {
        const appContent = fs.readFileSync(appPath, 'utf8');
        analysis.features = extractFeaturesFromApp(appContent);
      }
    }

  } catch (error) {
    console.error('Error analyzing codebase:', error.message);
  }

  return analysis;
}

function analyzeFolderStructure(dirPath, depth = 0) {
  const structure = {};
  
  if (depth > 3) return structure; // Prevent infinite recursion
  
  try {
    const items = fs.readdirSync(dirPath);
    
    for (const item of items) {
      const itemPath = path.join(dirPath, item);
      const stat = fs.statSync(itemPath);
      
      if (stat.isDirectory()) {
        structure[item] = analyzeFolderStructure(itemPath, depth + 1);
      } else {
        if (!structure.files) structure.files = [];
        structure.files.push(item);
      }
    }
  } catch (error) {
    // Ignore errors for inaccessible directories
  }
  
  return structure;
}

function getAllFiles(dirPath, extension) {
  let files = [];
  
  try {
    const items = fs.readdirSync(dirPath);
    
    for (const item of items) {
      const itemPath = path.join(dirPath, item);
      const stat = fs.statSync(itemPath);
      
      if (stat.isDirectory()) {
        files = files.concat(getAllFiles(itemPath, extension));
      } else if (item.endsWith(extension)) {
        files.push(itemPath);
      }
    }
  } catch (error) {
    // Ignore errors
  }
  
  return files;
}

function extractFeaturesFromApp(content) {
  const features = [];
  
  // Extract routes to understand features
  const routeMatches = content.match(/path="([^"]*)"[^>]*element={<(\w+)/g);
  if (routeMatches) {
    routeMatches.forEach(match => {
      const pathMatch = match.match(/path="([^"]*)"/);
      const componentMatch = match.match(/element={<(\w+)/);
      
      if (pathMatch && componentMatch) {
        const path = pathMatch[1];
        const component = componentMatch[1];
        
        if (path !== '*' && path !== '/') {
          features.push({
            name: component,
            path: path,
            description: generateFeatureDescription(component, path)
          });
        }
      }
    });
  }
  
  return features;
}

function generateFeatureDescription(component, path) {
  const descriptions = {
    'Venues': 'Browse and discover entertainment venues',
    'VenueDetail': 'View detailed information about specific venues',
    'Plans': 'Create and manage event plans',
    'PlanDetail': 'View and edit specific plan details',
    'SubmitReview': 'Submit reviews and ratings for venues',
    'Profile': 'Manage user profile and preferences',
    'Landing': 'Welcome page and app introduction'
  };
  
  return descriptions[component] || `${component} functionality`;
}

function generateReadme(analysis) {
  return `# ${analysis.projectName}

${analysis.description || 'A modern React application for discovering and planning entertainment experiences.'}

## 🚀 Tech Stack

${analysis.techStack.map(tech => `- ${tech}`).join('\n')}

## 📱 Features

${analysis.features.map(feature => `- **${feature.name}** (\`${feature.path}\`) - ${feature.description}`).join('\n')}

## 🏗️ Project Structure

\`\`\`
src/
├── components/          # Reusable UI components
├── routes/             # Page components and routing
├── services/           # API and business logic
├── data/              # Static data and mock data
├── icons/             # Custom icon components
├── lib/               # Utility functions
└── styles/            # Global styles and CSS
\`\`\`

## 🧩 Components

${analysis.components.map(comp => `- \`${comp}\``).join('\n')}

## 🛣️ Routes

${analysis.routes.map(route => `- \`/${route.toLowerCase()}\` - ${route} page`).join('\n')}

## 🚀 Development

\`\`\`bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Lint code
npm run lint
\`\`\`

## 📄 License

This project is private and proprietary.

---

*📝 This README is automatically generated and updated by Claude Code hooks.*
`;
}

function generateClaudeMd(analysis) {
  return `# RAVEN - Claude Code Context

## Project Overview

This is a React-based entertainment discovery and planning application built with modern web technologies.

## Key Information for Claude

### Tech Stack Context
- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite for fast development
- **Routing**: React Router DOM for SPA navigation
- **Styling**: Tailwind CSS with custom dark theme
- **Animations**: Framer Motion for smooth transitions
- **Icons**: Lucide React + custom SVG components

### Architecture Patterns
- **Component Structure**: Functional components with hooks
- **Routing**: File-based route organization in \`src/routes/\`
- **Services**: Separated business logic in \`src/services/\`
- **Data**: Mock data in \`src/data/\` for development
- **Styling**: Utility-first with Tailwind + custom CSS variables

### Development Commands
\`\`\`bash
npm run dev      # Start development server
npm run build    # Build for production  
npm run lint     # Run ESLint
npm run preview  # Preview production build
\`\`\`

### Code Conventions
- Use TypeScript for all components
- Follow React hooks patterns
- Prefer functional components
- Use Tailwind for styling
- Keep components small and focused
- Separate concerns (UI, logic, data)

### Key Features to Understand
1. **Venue Discovery** - Browse entertainment venues
2. **Event Planning** - Create and manage plans
3. **Review System** - Submit and view venue reviews
4. **User Profiles** - Personal user management
5. **Mobile-First** - Responsive design with bottom navigation

### Important Files
- \`src/App.tsx\` - Main app structure and routing
- \`src/components/RavenBottomNav.tsx\` - Bottom navigation
- \`src/routes/\` - All page components
- \`src/services/\` - Business logic and API calls
- \`tailwind.config.js\` - Theme configuration

### Current Status
- Project uses modern React patterns
- No backend integration yet (using mock data)
- Mobile-responsive design
- Dark theme with custom colors

---

*🤖 Auto-generated by Claude Code documentation hook*
`;
}

function main() {
  console.log('🔍 Analyzing codebase...');
  const analysis = analyzeCodebase();
  
  console.log('📝 Generating README.md...');
  const readme = generateReadme(analysis);
  fs.writeFileSync('README.md', readme);
  
  console.log('📋 Generating CLAUDE.md...');
  const claudeMd = generateClaudeMd(analysis);
  fs.writeFileSync('CLAUDE.md', claudeMd);
  
  console.log('✅ Documentation updated successfully!');
  console.log(`   - README.md (${readme.length} chars)`);
  console.log(`   - CLAUDE.md (${claudeMd.length} chars)`);
}

// Only run if called directly (ES module check)
if (import.meta.url.startsWith('file:') && process.argv[1] && import.meta.url.includes(process.argv[1].replace(/\\/g, '/'))) {
  main();
}

export { analyzeCodebase, generateReadme, generateClaudeMd };