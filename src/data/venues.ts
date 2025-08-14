import { Venue } from '../contracts/types';

// 夜店评价数据
export const nightclubs: Venue[] = [
  {
    id: 'berghain',
    name: 'Berghain',
    district: 'Friedrichshain',
    tags: ['techno', 'late-night', 'world-famous'],
    ratings: {
      music: 95,
      vibe: 88,
      crowd: 92,
      safety: 85,
    },
    hasLiveVibe: true,
    description: '世界顶级techno圣殿，严格门禁，但音响系统和氛围无与伦比。周末通宵达旦的电子音乐盛宴。',
    address: 'Am Wriezener Bahnhof',
  },
  {
    id: 'about-blank',
    name: 'About Blank',
    district: 'Friedrichshain',
    tags: ['techno', 'outdoor', 'inclusive'],
    ratings: {
      music: 82,
      vibe: 90,
      crowd: 85,
      safety: 88,
    },
    hasLiveVibe: true,
    description: '拥有户外花园的工业风夜店，门禁相对宽松，人群多样化，夏季户外派对特别棒。',
  },
  {
    id: 'watergate',
    name: 'Watergate',
    district: 'Kreuzberg',
    tags: ['house', 'techno', 'riverside'],
    ratings: {
      music: 85,
      vibe: 80,
      crowd: 78,
      safety: 90,
    },
    hasLiveVibe: false,
    description: '施普雷河畔的高端夜店，拥有绝佳河景，音响系统精良，适合house和techno爱好者。',
  },
  {
    id: 'ritter-butzke',
    name: 'Ritter Butzke',
    district: 'Kreuzberg',
    tags: ['techno', 'house', 'underground'],
    ratings: {
      music: 88,
      vibe: 85,
      crowd: 82,
      safety: 80,
    },
    hasLiveVibe: true,
    description: '隐藏在前报社印刷厂的地下夜店，氛围神秘，音乐质量上乘，真正的柏林地下文化体验。',
  },
  {
    id: 'klunkerkranich',
    name: 'Klunkerkranich',
    district: 'Neukölln',
    tags: ['house', 'disco', 'rooftop'],
    ratings: {
      music: 75,
      vibe: 92,
      crowd: 88,
      safety: 95,
    },
    hasLiveVibe: false,
    description: '购物中心顶楼的天台夜店，日落时分特别美丽，适合轻松的house和disco音乐。',
  },
];

// 酒吧评价数据
export const bars: Venue[] = [
  {
    id: 'zur-letzten-instanz',
    name: 'Zur Letzten Instanz',
    district: 'Mitte',
    tags: ['historic', 'traditional', 'beer-garden'],
    ratings: {
      music: 60,
      vibe: 85,
      crowd: 80,
      safety: 95,
    },
    hasLiveVibe: false,
    description: '柏林最古老的餐厅酒吧之一，拿破仑曾经光顾过。传统德式氛围，优质啤酒和香肠。',
    address: 'Waisenstraße 14-16',
  },
  {
    id: 'prater-garten',
    name: 'Prater Garten',
    district: 'Prenzlauer Berg',
    tags: ['beer-garden', 'outdoor', 'family-friendly'],
    ratings: {
      music: 50,
      vibe: 90,
      crowd: 85,
      safety: 95,
    },
    hasLiveVibe: false,
    description: '柏林最古老的啤酒花园，拥有600个座位。夏季必去，传统德式啤酒和烤肉，适合全家。',
    address: 'Kastanienallee 7-9',
  },
  {
    id: 'hackescher-hof',
    name: 'Hackescher Hof',
    district: 'Mitte',
    tags: ['cocktails', 'upscale', 'historic'],
    ratings: {
      music: 70,
      vibe: 88,
      crowd: 82,
      safety: 90,
    },
    hasLiveVibe: false,
    description: '位于哈克市场附近的精品鸡尾酒吧，调酒师技艺精湛，环境优雅，适合商务聚会。',
    address: 'Rosenthaler Str. 40-41',
  },
  {
    id: 'zur-wilden-renate',
    name: 'Zur Wilden Renate Bar',
    district: 'Neukölln',
    tags: ['alternative', 'quirky', 'late-night'],
    ratings: {
      music: 75,
      vibe: 92,
      crowd: 88,
      safety: 80,
    },
    hasLiveVibe: true,
    description: '前东德公寓改造的另类酒吧，每个房间都有不同主题，创意鸡尾酒，深夜营业。',
    address: 'Alt-Stralau 70',
  },
  {
    id: 'monkey-bar',
    name: 'Monkey Bar',
    district: 'Charlottenburg',
    tags: ['rooftop', 'upscale', 'city-view'],
    ratings: {
      music: 65,
      vibe: 85,
      crowd: 75,
      safety: 95,
    },
    hasLiveVibe: false,
    description: '25层高楼顶的景观酒吧，可俯瞰动物园和城市天际线，高端鸡尾酒，适合约会。',
    address: 'Budapester Str. 40',
  },
];

// 为了保持向后兼容，导出nightclubs作为venues
export const venues = nightclubs;