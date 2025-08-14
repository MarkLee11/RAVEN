// project/src/components/WordStreamReviews.tsx
import React, { useEffect, useState, useMemo } from 'react';

type Props = {
  density?: number;
  laneHeight?: number;
  colorsBase?: string;
  positiveRate?: number;
  anchorTopRef: React.RefObject<HTMLElement> | null;
  anchorBottomRef: React.RefObject<HTMLElement>;
};

interface ReviewFragment {
  text: string;
  isPositive: boolean;
}

const reviewFragments: ReviewFragment[] = [
  // EN — 11 pos / 11 neg
  { text: "Berghain door harsh tonight", isPositive: false },
  { text: "Berghain sound shook bones", isPositive: true },
  { text: "Watergate terrace sunrise magic", isPositive: true },
  { text: "Watergate too touristy lately", isPositive: false },
  { text: "Kater Blau river vibe perfect", isPositive: true },
  { text: "Kater Blau line unbearable", isPositive: false },
  { text: "Sisyphos morning energy unreal", isPositive: true },
  { text: "Sisyphos dusty and crowded", isPositive: false },
  { text: "Tresor raw techno done right", isPositive: true },
  { text: "Tresor basement heat brutal", isPositive: false },
  { text: "Wilde Renate quirky rooms fun", isPositive: true },
  { text: "Renate door vibe unfriendly", isPositive: false },
  { text: "about blank floor delivered", isPositive: true },
  { text: "about blank toilets a mess", isPositive: false },
  { text: "Club der Visionaere sunset bliss", isPositive: true },
  { text: "CDV drinks overpriced tonight", isPositive: false },
  { text: "Klunkerkranich rooftop view insane", isPositive: true },
  { text: "Klunkerkranich queue forever long", isPositive: false },
  { text: "Buck and Breck cocktails surgical", isPositive: true },
  { text: "Buck and Breck reservation hassle", isPositive: false },
  { text: "Green Door bartenders nailed classics", isPositive: true },
  { text: "Green Door too dark inside", isPositive: false },

  // DE — 11 pos / 11 neg
  { text: "Berghain Tür heute hart", isPositive: false },
  { text: "Berghain Sound enorm stark", isPositive: true },
  { text: "Watergate Terrasse Sonnenaufgang magisch", isPositive: true },
  { text: "Watergate inzwischen zu touristisch", isPositive: false },
  { text: "Kater Blau Flussvibe perfekt", isPositive: true },
  { text: "Kater Blau Schlange endlos", isPositive: false },
  { text: "Sisyphos Morgenenergie irre gut", isPositive: true },
  { text: "Sisyphos staubig und voll", isPositive: false },
  { text: "Tresor roher Techno vom Feinsten", isPositive: true },
  { text: "Tresor unten viel zu heiß", isPositive: false },
  { text: "Wilde Renate verrückte Räume Spaß", isPositive: true },
  { text: "Renate Türlaune unfreundlich", isPositive: false },
  { text: "about blank Floor hat geliefert", isPositive: true },
  { text: "about blank Toiletten chaotisch", isPositive: false },
  { text: "Club der Visionäre Sonnenuntergang traumhaft", isPositive: true },
  { text: "CDV Getränke heute zu teuer", isPositive: false },
  { text: "Klunkerkranich Dachblick der Wahnsinn", isPositive: true },
  { text: "Klunkerkranich Warten ewig", isPositive: false },
  { text: "Buck and Breck Cocktails präzise", isPositive: true },
  { text: "Buck and Breck Reservierung nervt", isPositive: false },
  { text: "Green Door Barkeeper top", isPositive: true },
  { text: "Green Door innen zu dunkel", isPositive: false },

  // ES — 11 pos / 11 neg
  { text: "Puerta de Berghain dura", isPositive: false },
  { text: "Sonido de Berghain brutal", isPositive: true },
  { text: "Amanecer en Watergate mágico", isPositive: true },
  { text: "Watergate demasiado turístico", isPositive: false },
  { text: "Kater Blau junto al río perfecto", isPositive: true },
  { text: "Cola de Kater Blau eterna", isPositive: false },
  { text: "Energía matinal en Sisyphos increíble", isPositive: true },
  { text: "Sisyphos polvoriento y lleno", isPositive: false },
  { text: "Tresor techno crudo de verdad", isPositive: true },
  { text: "Sótano de Tresor sofocante", isPositive: false },
  { text: "Renate salas raras divertidas", isPositive: true },
  { text: "Renate puerta antipática", isPositive: false },
  { text: "about blank pista cumplió", isPositive: true },
  { text: "about blank baños desastrosos", isPositive: false },
  { text: "Club der Visionäre atardecer hermoso", isPositive: true },
  { text: "CDV copas caras hoy", isPositive: false },
  { text: "Vista de Klunkerkranich tremenda", isPositive: true },
  { text: "Fila en Klunkerkranich interminable", isPositive: false },
  { text: "Buck and Breck cócteles finos", isPositive: true },
  { text: "Buck and Breck reserva pesada", isPositive: false },
  { text: "Green Door bartenders excelentes", isPositive: true },
  { text: "Green Door demasiado oscuro dentro", isPositive: false },

  // FR — 11 pos / 11 neg
  { text: "Porte de Berghain sévère", isPositive: false },
  { text: "Son de Berghain monstrueux", isPositive: true },
  { text: "Aube magique à Watergate", isPositive: true },
  { text: "Watergate trop touristique", isPositive: false },
  { text: "Kater Blau au bord de l’eau parfait", isPositive: true },
  { text: "File de Kater Blau sans fin", isPositive: false },
  { text: "Énergie du matin à Sisyphos folle", isPositive: true },
  { text: "Sisyphos poussiéreux et bondé", isPositive: false },
  { text: "Tresor techno brut impeccable", isPositive: true },
  { text: "Sous-sol de Tresor étouffant", isPositive: false },
  { text: "Renate salles déjantées amusantes", isPositive: true },
  { text: "Renate accueil porte froid", isPositive: false },
  { text: "about blank a bien livré", isPositive: true },
  { text: "Toilettes d’about blank en vrac", isPositive: false },
  { text: "Coucher de soleil au Club der Visionäre", isPositive: true },
  { text: "CDV verres trop chers ce soir", isPositive: false },
  { text: "Vue de Klunkerkranich dingue", isPositive: true },
  { text: "Queue Klunkerkranich interminable", isPositive: false },
  { text: "Buck and Breck cocktails précis", isPositive: true },
  { text: "Buck and Breck réservation pénible", isPositive: false },
  { text: "Green Door barmen au top", isPositive: true },
  { text: "Green Door trop sombre dedans", isPositive: false },

  // ZH — 11 pos / 11 neg
  { text: "Berghain 门口很严", isPositive: false },
  { text: "Berghain 声场很猛", isPositive: true },
  { text: "Watergate 日出太美了", isPositive: true },
  { text: "Watergate 游客有点多", isPositive: false },
  { text: "Kater Blau 河边氛围绝", isPositive: true },
  { text: "Kater Blau 排队太久", isPositive: false },
  { text: "Sisyphos 早晨能量爆", isPositive: true },
  { text: "Sisyphos 灰大人多", isPositive: false },
  { text: "Tresor 工业味很正", isPositive: true },
  { text: "Tresor 地下太闷热", isPositive: false },
  { text: "Renate 房间又疯又好玩", isPositive: true },
  { text: "Renate 门口脸色差", isPositive: false },
  { text: "about blank 舞池给力", isPositive: true },
  { text: "about blank 卫生间一团糟", isPositive: false },
  { text: "Club der Visionäre 日落很美", isPositive: true },
  { text: "CDV 酒水今天偏贵", isPositive: false },
  { text: "Klunkerkranich 天台视野逆天", isPositive: true },
  { text: "Klunkerkranich 队伍太长", isPositive: false },
  { text: "Buck and Breck 调酒很准", isPositive: true },
  { text: "Buck and Breck 订位太麻烦", isPositive: false },
  { text: "Green Door 调酒师很稳", isPositive: true },
  { text: "Green Door 里面太暗", isPositive: false },

  // RU — 11 pos / 11 neg
  { text: "В Berghain жёсткий фейс-контроль", isPositive: false },
  { text: "Звук в Berghain мощнейший", isPositive: true },
  { text: "Рассвет на Watergate волшебный", isPositive: true },
  { text: "Watergate стал слишком туристическим", isPositive: false },
  { text: "Kater Blau у реки — идеально", isPositive: true },
  { text: "Очередь в Kater Blau бесконечная", isPositive: false },
  { text: "Утренний вайб Sisyphos безумный", isPositive: true },
  { text: "Sisyphos пыльно и тесно", isPositive: false },
  { text: "Tresor — честный сырой техно", isPositive: true },
  { text: "Подвал Tresor душный и жаркий", isPositive: false },
  { text: "Renate — странные комнаты, весело", isPositive: true },
  { text: "Renate — недружелюбный вход", isPositive: false },
  { text: "about blank — танцпол зажёг", isPositive: true },
  { text: "about blank — туалеты ужас", isPositive: false },
  { text: "Закат в Club der Visionäre красив", isPositive: true },
  { text: "CDV — напитки дорогие сегодня", isPositive: false },
  { text: "Вид с Klunkerkranich сумасшедший", isPositive: true },
  { text: "Очередь в Klunkerkranich бесконечна", isPositive: false },
  { text: "Buck and Breck — коктейли точные", isPositive: true },
  { text: "Buck and Breck — бронь утомляет", isPositive: false },
  { text: "Green Door — бармены отличные", isPositive: true },
  { text: "Green Door — внутри слишком темно", isPositive: false },

  // IT — 11 pos / 11 neg
  { text: "Porta del Berghain dura", isPositive: false },
  { text: "Suono al Berghain pazzesco", isPositive: true },
  { text: "Alba al Watergate magica", isPositive: true },
  { text: "Watergate troppo turistico", isPositive: false },
  { text: "Kater Blau sul fiume perfetto", isPositive: true },
  { text: "Coda di Kater Blau infinita", isPositive: false },
  { text: "Energia mattutina a Sisyphos folle", isPositive: true },
  { text: "Sisyphos polveroso e pieno", isPositive: false },
  { text: "Tresor techno grezzo fatto bene", isPositive: true },
  { text: "Sotterraneo di Tresor soffocante", isPositive: false },
  { text: "Renate stanze folli divertenti", isPositive: true },
  { text: "Renate porta poco amichevole", isPositive: false },
  { text: "about blank pista ha spaccato", isPositive: true },
  { text: "Bagni di about blank disastro", isPositive: false },
  { text: "Tramonto a Club der Visionäre splendido", isPositive: true },
  { text: "CDV drink troppo cari stasera", isPositive: false },
  { text: "Vista Klunkerkranich pazzesca", isPositive: true },
  { text: "Fila a Klunkerkranich interminabile", isPositive: false },
  { text: "Buck and Breck cocktail chirurgici", isPositive: true },
  { text: "Buck and Breck prenotazione rognosa", isPositive: false },
  { text: "Green Door bartender eccellenti", isPositive: true },
  { text: "Green Door troppo buio dentro", isPositive: false },

  // HI — 11 pos / 11 neg
  { text: "Berghain का दरवाज़ा सख्त", isPositive: false },
  { text: "Berghain का साउंड दमदार", isPositive: true },
  { text: "Watergate की सुबह जादुई", isPositive: true },
  { text: "Watergate अब बहुत टूरिस्ट", isPositive: false },
  { text: "Kater Blau नदी किनारे बढ़िया", isPositive: true },
  { text: "Kater Blau की कतार अंतहीन", isPositive: false },
  { text: "Sisyphos सुबह की एनर्जी पागल", isPositive: true },
  { text: "Sisyphos धूल और भीड़", isPositive: false },
  { text: "Tresor रॉ टेक्नो सही", isPositive: true },
  { text: "Tresor बेसमेंट बहुत गर्म", isPositive: false },
  { text: "Renate के कमरे मज़ेदार", isPositive: true },
  { text: "Renate एंट्री पर व्यवहार ठंडा", isPositive: false },
  { text: "about blank डांसफ्लोर धमाकेदार", isPositive: true },
  { text: "about blank के बाथरूम गंदे", isPositive: false },
  { text: "Club der Visionäre का सनसेट खूबसूरत", isPositive: true },
  { text: "CDV ड्रिंक्स आज महंगे", isPositive: false },
  { text: "Klunkerkranich का व्यू कमाल", isPositive: true },
  { text: "Klunkerkranich में इंतज़ार लंबा", isPositive: false },
  { text: "Buck and Breck कॉकटेल बेहतरीन", isPositive: true },
  { text: "Buck and Breck की बुकिंग झंझट", isPositive: false },
  { text: "Green Door बारटेंडर बढ़िया", isPositive: true },
  { text: "Green Door अंदर बहुत अंधेरा", isPositive: false },

  // AR — 11 pos / 11 neg
  { text: "باب برغهاين قاسٍ الليلة", isPositive: false },
  { text: "صوت برغهاين هائل", isPositive: true },
  { text: "شروق ووترغيت سحري", isPositive: true },
  { text: "ووترغيت سياحي جدًا الآن", isPositive: false },
  { text: "كاتر بلاو على النهر رائع", isPositive: true },
  { text: "طابور كاتر بلاو لا ينتهي", isPositive: false },
  { text: "طاقة الصباح في سيزيفوس مجنونة", isPositive: true },
  { text: "سيزيفوس مغبر ومزدحم", isPositive: false },
  { text: "تريزور تكنو خام ممتاز", isPositive: true },
  { text: "قبو تريزور خانق وحار", isPositive: false },
  { text: "رِيناتِه غرف غريبة وممتعة", isPositive: true },
  { text: "مدخل رِيناتِه غير ودّي", isPositive: false },
  { text: "about blank أرضية رقص اشتعلت", isPositive: true },
  { text: "حمّامات about blank فوضى", isPositive: false },
  { text: "غروب نادي فيزيونيري جميل", isPositive: true },
  { text: "مشروبات CDV غالية الليلة", isPositive: false },
  { text: "منظر كلونكركرانيخ مذهل", isPositive: true },
  { text: "طابور كلونكركرانيخ طويل جدًا", isPositive: false },
  { text: "Buck and Breck كوكتيلات متقنة", isPositive: true },
  { text: "حجز Buck and Breck مزعج", isPositive: false },
  { text: "Green Door السقاة ممتازون", isPositive: true },
  { text: "Green Door داخله مظلم جدًا", isPositive: false },

  // TR — 11 pos / 11 neg
  { text: "Berghain kapı çok sert", isPositive: false },
  { text: "Berghain ses efsane güçlü", isPositive: true },
  { text: "Watergate şafak manzarası büyülü", isPositive: true },
  { text: "Watergate fazla turistik oldu", isPositive: false },
  { text: "Kater Blau nehir kıyısı harika", isPositive: true },
  { text: "Kater Blau kuyruğu bitmiyor", isPositive: false },
  { text: "Sisyphos sabah enerjisi çılgın", isPositive: true },
  { text: "Sisyphos tozlu ve kalabalık", isPositive: false },
  { text: "Tresor ham techno yerinde", isPositive: true },
  { text: "Tresor bodrumu bunaltıcı sıcak", isPositive: false },
  { text: "Renate odalar tuhaf eğlenceli", isPositive: true },
  { text: "Renate kapı tavrı soğuk", isPositive: false },
  { text: "about blank pist ateşledi", isPositive: true },
  { text: "about blank tuvaletler darmadağın", isPositive: false },
  { text: "Club der Visionäre gün batımı efsane", isPositive: true },
  { text: "CDV içkiler bu gece pahalı", isPositive: false },
  { text: "Klunkerkranich manzara akıl almaz", isPositive: true },
  { text: "Klunkerkranich bekleme sonsuz", isPositive: false },
  { text: "Buck and Breck kokteyller ustalık işi", isPositive: true },
  { text: "Buck and Breck rezervasyon dertli", isPositive: false },
  { text: "Green Door barmenler çok iyi", isPositive: true },
  { text: "Green Door içerisi aşırı karanlık", isPositive: false },
];


const WordStreamReviews: React.FC<Props> = ({
  density = 42,
  laneHeight = 96,
  colorsBase = '#8ACE00',
  positiveRate = 0.6,
  anchorTopRef,
  anchorBottomRef,
}) => {
  const [dimensions, setDimensions] = useState({ top: 0, height: laneHeight });

  // ---- palette from base ----
  const colorPalette = useMemo(() => {
    const hexToHsl = (hex: string) => {
      const r = parseInt(hex.slice(1, 3), 16) / 255;
      const g = parseInt(hex.slice(3, 5), 16) / 255;
      const b = parseInt(hex.slice(5, 7), 16) / 255;
      const max = Math.max(r, g, b), min = Math.min(r, g, b);
      let h = 0, s = 0, l = (max + min) / 2;
      if (max !== min) {
        const d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        switch (max) {
          case r: h = (g - b) / d + (g < b ? 6 : 0); break;
          case g: h = (b - r) / d + 2; break;
          case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
      }
      return [h * 360, s * 100, l * 100] as [number, number, number];
    };
    const hslToHex = (h: number, s: number, l: number) => {
      h /= 360; s /= 100; l /= 100;
      const c = (1 - Math.abs(2 * l - 1)) * s;
      const x = c * (1 - Math.abs((h * 6) % 2 - 1));
      const m = l - c / 2;
      let r = 0, g = 0, b = 0;
      if (0 <= h && h < 1/6) { r = c; g = x; b = 0; }
      else if (1/6 <= h && h < 2/6) { r = x; g = c; b = 0; }
      else if (2/6 <= h && h < 3/6) { r = 0; g = c; b = x; }
      else if (3/6 <= h && h < 4/6) { r = 0; g = x; b = c; }
      else if (4/6 <= h && h < 5/6) { r = x; g = 0; b = c; }
      else if (5/6 <= h && h < 1) { r = c; g = 0; b = x; }
      r = Math.round((r + m) * 255);
      g = Math.round((g + m) * 255);
      b = Math.round((b + m) * 255);
      return `#${r.toString(16).padStart(2,'0')}${g.toString(16).padStart(2,'0')}${b.toString(16).padStart(2,'0')}`;
    };

    const [h, s, l] = hexToHsl(colorsBase);
    return [
      colorsBase,
      hslToHex(h, s, Math.min(100, l + 8)),
      hslToHex(h, s, Math.min(100, l + 16)),
      hslToHex(h, s, Math.min(100, l + 24)),
      hslToHex(h, s, Math.max(0, l - 8)),
      hslToHex(h, s, Math.max(0, l - 16)),
      hslToHex(h, s, Math.max(0, l - 24)),
      hslToHex((h + 8) % 360, s, l),
      hslToHex((h - 8 + 360) % 360, s, l),
      '#E6E6E6', '#A3A3A3',
    ];
  }, [colorsBase]);

  // ---- items ----
  const wordItems = useMemo(() => {
    const items: Array<{
      id: number; text: string; x: number; direction: 'up'|'down';
      delay: number; duration: number; phaseDelay: number;
      scale: number; opacity: number; color: string;
      startOffset: number; swayAmp: number; swayDur: number; swayPhase: number;
    }> = [];

    for (let i = 0; i < density; i++) {
      const shouldBePositive = Math.random() < positiveRate;
      const pool = reviewFragments.filter(f => f.isPositive === shouldBePositive);
      const fragment = pool[Math.floor(Math.random() * pool.length)];

      const direction: 'up'|'down' = Math.random() > 0.5 ? 'up' : 'down';

      // 更广的起点范围（避免进入视区时扎堆）
      const startOffset = direction === 'down'
        ? -(50 + Math.random() * 350)   // -50vh ~ -400vh
        : 50;                            // 向上：从容器下方 50vh 起

      // 速度差更大（0.5x ~ 1.7x）
      const speedVariation =(0.8 + Math.random() * 0.9);

      const baseDuration = 8 + Math.random() * 10; // 8–18s
      const duration = baseDuration * speedVariation;

      // 根据“起点距离/速度”估算抵达时间，反向设置延迟，避免追尾同步
      const travelTime = Math.abs(startOffset) / (100 * speedVariation); // 以 100vh 为单位
      const baseDelay = direction === 'down'
        ? travelTime * (0.8 + Math.random() * 0.4)
        : Math.random() * 10;

      // 关键：负相位，让每个元素一出现就处在不同进度
      const phaseDelay = -Math.random() * duration;

      // 水平摆动参数（用第二个动画改 margin-left，不与 transform 冲突）
      const swayAmp = (Math.random() - 0.5) * 40;         // ±20px
      const swayDur = 1.6 + Math.random() * 2.2;          // 1.6–3.8s
      const swayPhase = Math.random() * swayDur;

      items.push({
        id: i,
        text: fragment.text,
        x: Math.random() * 100, // vw
        direction,
        delay: Math.max(0, baseDelay),
        duration,
        phaseDelay,
        scale: 0.9 + Math.random() * 0.3,
        opacity: 0.4 + Math.random() * 0.4,
        color: colorPalette[Math.floor(Math.random() * colorPalette.length)],
        startOffset,
        swayAmp,
        swayDur,
        swayPhase,
      });
    }
    return items;
  }, [density, positiveRate, colorPalette]);

  // ---- place lane between header and cards ----
  useEffect(() => {
    const update = () => {
      const topNavHeight = 64;
      const topPosition = topNavHeight + 4;
      let h = laneHeight;
      if (anchorBottomRef?.current) {
        const cardsRect = anchorBottomRef.current.getBoundingClientRect();
        const available = cardsRect.top - topPosition - 8;
        h = Math.max(64, available);
      }
      setDimensions({ top: topPosition, height: h });
    };
    update();
    window.addEventListener('resize', update);
    const ro = new ResizeObserver(update);
    anchorBottomRef?.current && ro.observe(anchorBottomRef.current);
    return () => { window.removeEventListener('resize', update); ro.disconnect(); };
  }, [laneHeight, anchorBottomRef]);

  return (
    <>
      <style>{`
        /* 垂直：只做起点→终点，避免中途相位同步 */
        @keyframes rise {
          0%   { transform: translate3d(var(--tx,0), 50vh, 0) scale(var(--scale,1)); opacity: 0; }
          10%  { opacity: var(--op,0.6); }
          100% { transform: translate3d(var(--tx,0), -120vh, 0) scale(var(--scale,1)); opacity: 0; }
        }
        @keyframes fall {
          0%   { transform: translate3d(var(--tx,0), var(--start-offset,0), 0) scale(var(--scale,1)); opacity: 0; }
          10%  { opacity: var(--op,0.6); }
          100% { transform: translate3d(var(--tx,0), 120vh, 0) scale(var(--scale,1)); opacity: 0; }
        }
        /* 水平：第二个动画，改 margin-left，避免和 transform 叠加冲突 */
        @keyframes sway {
          0%   { margin-left: calc(var(--mx, 0px) * -1); }
          100% { margin-left: var(--mx, 0px); }
        }
        .word-stream-item {
          position: absolute;
          top: 0; left: 0;
          will-change: transform, opacity, margin-left;
          font-weight: 600;
          letter-spacing: 0.02em;
          mix-blend-mode: screen;
          text-shadow: 0 0 10px rgba(0,0,0,0.35);
          white-space: nowrap;
        }
        @media (prefers-reduced-motion: reduce) {
          .word-stream-item { animation: none !important; opacity: 0.3 !important; position: static !important; transform: none !important; margin-left: 0 !important; }
        }
      `}</style>

      <div
        aria-hidden="true"
        style={{
          position: 'absolute',
          left: 0, right: 0,
          top: dimensions.top,
          height: dimensions.height,
          zIndex: 30,
          pointerEvents: 'none',
          overflow: 'hidden',
        }}
      >
        {wordItems.map((item) => {
          const main = `${item.direction === 'down' ? 'fall' : 'rise'} ${item.duration}s linear ${item.phaseDelay}s infinite`;
          const sway = `sway ${item.swayDur}s ease-in-out ${item.swayPhase}s infinite alternate`;
          return (
            <div
              key={item.id}
              className="word-stream-item text-sm font-medium"
              style={{
                left: `calc(${item.x}vw - 80px)`,
                color: item.color,
                animation: `${main}, ${sway}`,
                // custom props used in keyframes
                ['--tx' as any]: `${(Math.random() - 0.5) * 20}px`,
                ['--scale' as any]: item.scale,
                ['--op' as any]: item.opacity,
                ['--start-offset' as any]: `${item.startOffset}vh`,
                ['--mx' as any]: `${item.swayAmp}px`,
              } as React.CSSProperties}
            >
              {item.text}
            </div>
          );
        })}
      </div>
    </>
  );
};

export default WordStreamReviews;
