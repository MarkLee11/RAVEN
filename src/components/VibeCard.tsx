import React from 'react';
import { Clock, Zap, Users, Shield, AlertTriangle } from 'lucide-react';
import { VibeSummary } from '../contracts/types';
import { formatTimeAgo } from '../lib/utils';
import Card from './ui/Card';

interface VibeCardProps {
  summary: VibeSummary;
}

const VibeCard: React.FC<VibeCardProps> = ({ summary }) => {
  const indicators = [
    {
      icon: AlertTriangle,
      label: 'Door',
      value: summary.doorStrictness,
      color: summary.doorStrictness > 70 ? 'text-blood' : summary.doorStrictness > 40 ? 'text-yellow-500' : 'text-brat'
    },
    {
      icon: Clock,
      label: 'Queue',
      value: `${summary.queueEstimate}m`,
      color: summary.queueEstimate > 60 ? 'text-blood' : summary.queueEstimate > 30 ? 'text-yellow-500' : 'text-brat'
    },
    {
      icon: Zap,
      label: 'Music',
      value: summary.musicIntensity,
      color: summary.musicIntensity > 80 ? 'text-raven' : 'text-ash'
    },
    {
      icon: Users,
      label: 'Crowd',
      value: summary.crowdHeat,
      color: summary.crowdHeat > 80 ? 'text-blood' : summary.crowdHeat > 60 ? 'text-raven' : 'text-ash'
    },
  ];

  return (
    <Card className="border-raven/30">
      <div className="flex items-center justify-between mb-3">
        <h3 className="font-space text-lg text-ink">Tonight's Vibe</h3>
        <div className="flex items-center space-x-1 text-xs text-ash">
          <div className="w-2 h-2 bg-raven rounded-full animate-pulse" />
          <span>LIVE · {formatTimeAgo(summary.lastUpdated)}</span>
        </div>
      </div>

      <div className="grid grid-cols-4 gap-4 mb-4">
        {indicators.map(({ icon: Icon, label, value, color }) => (
          <div key={label} className="text-center">
            <Icon size={16} className={`mx-auto mb-1 ${color}`} />
            <div className="text-xs text-ash mb-1">{label}</div>
            <div className={`text-sm font-semibold ${color}`}>
              {typeof value === 'number' && label !== 'Queue' ? `${value}%` : value}
            </div>
          </div>
        ))}
      </div>

      <div className="bg-berlin-black/50 p-3 rounded border border-ash/10">
        <p className="text-sm text-ink leading-relaxed">
          {summary.suggestion}
        </p>
        {summary.bestWindow && (
          <p className="text-xs text-raven mt-2 font-medium">
            Best window: {summary.bestWindow}
          </p>
        )}
      </div>
    </Card>
  );
};

export default VibeCard;