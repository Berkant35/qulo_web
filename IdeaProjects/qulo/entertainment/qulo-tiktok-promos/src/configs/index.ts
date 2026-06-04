import type {PromoConfig} from '../types';
import {stopSwipingConfig} from './stop-swiping.config';
import {dayInTheLifeConfig} from './day-in-the-life.config';
import {matchToFirstDateConfig} from './match-to-first-date.config';
import {fullAppIntroConfig} from './full-app-intro.config';

const REGISTRY: Record<string, PromoConfig> = {
  'stop-swiping': stopSwipingConfig,
  'day-in-the-life': dayInTheLifeConfig,
  'match-to-first-date': matchToFirstDateConfig,
  'full-app-intro': fullAppIntroConfig,
};

export const getConfig = (slug: string): PromoConfig => {
  const cfg = REGISTRY[slug];
  if (!cfg) {
    throw new Error(`Unknown promo configSlug: "${slug}". Known: ${Object.keys(REGISTRY).join(', ')}`);
  }
  return cfg;
};

export const allConfigSlugs = (): string[] => Object.keys(REGISTRY);
