import { VibeSample } from '../contracts/types';

export const vibeSamples: VibeSample[] = [
  {
    id: 'v1',
    venueId: 'berghain',
    timestamp: new Date('2024-12-25T02:15:00'),
    doorStrictness: 95,
    queueEstimate: 75,
    musicIntensity: 98,
    crowdHeat: 90,
    suggestion: 'Door vibe: unsmiling tonight. Queue ~75m. Bass is viscous. If you go: black everything, no phones visible.',
  },
  {
    id: 'v2',
    venueId: 'about-blank',
    timestamp: new Date('2024-12-25T01:45:00'),
    doorStrictness: 40,
    queueEstimate: 25,
    musicIntensity: 85,
    crowdHeat: 88,
    suggestion: 'Garden heating up after midnight. Mixed crowd energy building. Best window: now until 03:00.',
  },
  {
    id: 'v3',
    venueId: 'ritter-butzke',
    timestamp: new Date('2024-12-25T00:30:00'),
    doorStrictness: 60,
    queueEstimate: 45,
    musicIntensity: 92,
    crowdHeat: 82,
    suggestion: 'Heat spiking after 01:30. Find the hidden entrance. Cash ready, patience required.',
  },
];