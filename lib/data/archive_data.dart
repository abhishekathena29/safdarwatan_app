import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The kind of an archive item — drives the placeholder icon and accent
/// colour used across cards (the live site has no reliable image URLs, so we
/// render typed sepia placeholders consistent with [ArchiveImage]).
enum ItemKind {
  oralHistory('Oral History', Icons.graphic_eq),
  movingImage('Moving Image', Icons.smart_display),
  podcast('Podcast', Icons.podcasts),
  event('Event', Icons.event),
  research('Research', Icons.history_edu),
  visual('Visual', Icons.image);

  const ItemKind(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// A single catalogued item in the archive, mirroring the Dublin Core
/// records on https://safardarwatan.omeka.net/items/browse.
class ArchiveItem {
  const ArchiveItem({
    required this.catalogNo,
    required this.title,
    required this.kind,
    this.subtitle,
    this.description,
    this.tags = const [],
    this.creator = 'Aania Sayida Mir',
    this.duration,
    this.collectionId,
    this.caption,
  });

  /// Omeka item number (e.g. 38) — shown as "Item #38".
  final int catalogNo;
  final String title;
  final ItemKind kind;
  final String? subtitle;
  final String? description;
  final List<String> tags;
  final String creator;
  final String? duration;

  /// Id of the owning [Collection], when known.
  final String? collectionId;

  /// Short caption rendered onto the placeholder image.
  final String? caption;
}

/// A heritage collection (Omeka collection). Reuses the colour story already
/// established on the Collections screen.
class Collection {
  const Collection({
    required this.id,
    required this.kashmiri,
    required this.title,
    required this.description,
    required this.color,
  });

  final String id;
  final String kashmiri;
  final String title;
  final String description;
  final Color color;
}

/// A thematic exhibit (Omeka exhibit) — a curated narrative built from items.
class Exhibit {
  const Exhibit({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.body,
    required this.pullQuote,
    required this.tags,
    required this.artifacts,
  });

  final String title;
  final String subtitle;
  final String summary;
  final String body;
  final String pullQuote;
  final List<String> tags;
  final List<ExhibitArtifact> artifacts;
}

/// A single plate/artifact shown inside an exhibit gallery.
class ExhibitArtifact {
  const ExhibitArtifact({
    required this.catalogNo,
    required this.title,
    required this.note,
    required this.icon,
    this.featured = false,
  });

  final String catalogNo;
  final String title;
  final String note;
  final IconData icon;
  final bool featured;
}

// ── Data ─────────────────────────────────────────────────────────────────
// Sourced from safardarwatan.omeka.net (extracted 2026-06-10).

const List<Collection> kCollections = [
  Collection(
    id: 'shayari',
    kashmiri: 'شاعری (shayari)',
    title: 'Poetry of the Valley',
    description:
        'A curated selection of Kashmiri verse, from the mystical Vakhs of '
        'Lal Ded to contemporary resistance literature.',
    color: AppColors.poetryBlue,
  ),
  Collection(
    id: 'wupkar',
    kashmiri: 'وپکار (wupkar)',
    title: 'Community Outreach & Global Awareness',
    description:
        'Elevating voices that echo through the chinar trees, bridging the gap '
        'between exile and identity.',
    color: AppColors.primary,
  ),
  Collection(
    id: 'khyawun',
    kashmiri: 'کھیوٚن (khyawun)',
    title: 'Traditional Cuisine',
    description:
        'Wazwan and the hearth — recipes, rituals and the flavours that carry '
        'the memory of home.',
    color: AppColors.secondary,
  ),
  Collection(
    id: 'karigari',
    kashmiri: 'کاریگَری (kārigāri)',
    title: 'Traditional Arts & Crafts',
    description:
        'Papier-mâché, Pashmina weaving, and walnut wood carving. The hands of '
        'the masters preserved in pixels.',
    color: AppColors.tertiary,
  ),
  Collection(
    id: 'fanetaameer',
    kashmiri: 'فن تأمیر (Fan-e-ta\'ameer)',
    title: 'Cultural Heritage & Architecture',
    description:
        'Tracing the Sultanate, Afghan, and Sikh inscriptions on the stones of '
        'the valley. A study in stone and soul.',
    color: AppColors.onSurface,
  ),
  Collection(
    id: 'daastan',
    kashmiri: 'داستاں (daastan)',
    title: 'Oral Histories & Narratives',
    description:
        'Living memory — interviews and personal histories from Kashmiris at '
        'home and in the diaspora.',
    color: AppColors.onPrimaryFixedVariant,
  ),
  Collection(
    id: 'gyavun',
    kashmiri: 'گیوٕن (gyavun)',
    title: 'Music',
    description:
        'Melodies that carry the whispers of the mountains — evenings of song '
        'and the instruments of the valley.',
    color: AppColors.secondary,
  ),
];

const List<ArchiveItem> kItems = [
  ArchiveItem(
    catalogNo: 39,
    title: 'What is Worth Preserving in Digital Archiving?',
    kind: ItemKind.research,
    subtitle:
        'Community, Consent and an Exploration of the Psychology of Preservation',
    description:
        'This research critically examines the epistemological, ethical, and '
        'methodological dimensions of digital archiving in the preservation of '
        'Kashmiri cultural heritage. Anchored in the central question — what '
        'is worth preserving in digital archiving? — the study interrogates '
        'how intangible and vernacular heritage practices are engaged, '
        'contested, or excluded in technologically mediated preservation '
        'efforts. Utilizing a qualitative ethnographic framework, the '
        'research incorporates seven semi-structured interviews conducted '
        'through a publicly accessible podcast series on Spotify, each '
        'exploring the psychology of preservation from intergenerational, '
        'gendered, and community-based perspectives, complemented by field '
        'documentation at historically and spiritually significant sites in '
        'Srinagar.',
    tags: ['narrative', 'culture', 'research'],
    caption: 'Manuscript',
  ),
  ArchiveItem(
    catalogNo: 38,
    title: 'Naqsh.....The Imprint',
    kind: ItemKind.visual,
    subtitle: 'Architectural Epigraphy',
    description:
        'Visual documentation of Sultanate-era inscriptions in Srinagar\'s '
        'historic quarter.',
    tags: ['visual', 'architecture'],
    collectionId: 'fanetaameer',
    caption: 'The Imprint',
  ),
  ArchiveItem(
    catalogNo: 37,
    title: 'Intricate Calligraphy',
    kind: ItemKind.visual,
    subtitle: '15th Century Persian Script',
    description:
        'A plate from the Naqsh documentation — Persian calligraphy carved '
        'into the stone of a heritage site.',
    tags: ['architecture', 'epigraphy'],
    collectionId: 'fanetaameer',
    caption: 'Calligraphy',
  ),
  ArchiveItem(
    catalogNo: 36,
    title: 'Stone Carvings',
    kind: ItemKind.visual,
    subtitle: 'Basalt Etchings',
    description:
        'Documentation of basalt etchings surviving across Kashmir\'s built '
        'heritage.',
    tags: ['architecture', 'crafts'],
    collectionId: 'fanetaameer',
    caption: 'Basalt',
  ),
  ArchiveItem(
    catalogNo: 35,
    title: 'Hānkal — Metal Chains in Architecture',
    kind: ItemKind.visual,
    subtitle: 'Metalwork',
    description:
        'A study of the metal chains and fittings that adorn Kashmiri '
        'architectural heritage.',
    tags: ['architecture', 'crafts'],
    collectionId: 'fanetaameer',
    caption: 'Hānkal',
  ),
  ArchiveItem(
    catalogNo: 31,
    title: 'Etchings in Stone: Voices of Kashmir\'s Architectural Epigraphy',
    kind: ItemKind.movingImage,
    subtitle: 'Short Documentary',
    description:
        'How do buildings speak? Through carved verses, poetic inscriptions, '
        'and words etched into their very walls. This episode explores '
        'architectural epigraphy — the art and history of inscriptions carved '
        'on stone, wood, and metal across Kashmir\'s built heritage — through '
        'the exhibition Naqsh… The Imprint, curated by Dr. Hakim Sameer '
        'Hamdani and his team at the School of Architecture and Planning, '
        'IUST, Awantipora. Supported by a Conservation Grant from the Barakat '
        'Trust (U.K.), the year-long (2023–24) project surveyed over 600 '
        'sites across Kashmir, studying 41 inscriptions in depth — from '
        'mosques and shrines to bridges and mausoleums.',
    tags: [
      'architecture',
      'cultural heritage',
      'exhibit',
      'short documentary',
      'video',
      'visual',
    ],
    collectionId: 'fanetaameer',
    caption: 'Etchings',
  ),
  ArchiveItem(
    catalogNo: 30,
    title: 'Parihaspora: The City of Laughter',
    kind: ItemKind.movingImage,
    subtitle: 'Historical Narrative',
    description:
        'We travel to Parihāsapura, the legendary "City of Laughter," '
        'perched above the Vitasta (now the Jhelum River) in the Kashmir '
        'Valley. Founded by Lalitaditya Muktapida in the mid-8th century CE, '
        'this was more than a capital — it was an epicenter of artistry, '
        'devotion, and urban grandeur, its vision realized in four majestic '
        'temples adorned with colossal gold, silver, and bronze images, some '
        'towering over 4 meters tall. The city declined after the court '
        'returned to Srinagar, its sacred structures cannibalized by later '
        'rulers; today, only stones remain, speaking still of power, faith, '
        'and an imperial dream that once soared above the valley.',
    tags: ['video', 'history', 'narrative'],
    collectionId: 'fanetaameer',
    caption: 'Parihaspora',
  ),
  ArchiveItem(
    catalogNo: 29,
    title: 'Gyavun: Echoes of the Valley',
    kind: ItemKind.event,
    subtitle: 'A musical evening with Noor Mohammad Shah',
    description:
        'A musical evening of Kashmiri song with Noor Mohammad Shah, performed '
        'in Kashmiri with English translation.',
    tags: ['gyavun', 'music', 'noor mohammad shah', 'oral history'],
    collectionId: 'gyavun',
    caption: 'Gyavun',
  ),
  ArchiveItem(
    catalogNo: 23,
    title: 'Hazaar Dastaan: A Thousand Stories of Srinagar\'s Old City',
    kind: ItemKind.movingImage,
    subtitle: 'Documentary',
    description:
        'A documentary gathering a thousand stories from Srinagar\'s old city, '
        'featuring Dr Sara Khalid, Mr Shakir Mir and Ms Naveed Iqbal.',
    tags: ['documentary', 'narrative', 'culture'],
    collectionId: 'fanetaameer',
    caption: 'Old City',
  ),
  ArchiveItem(
    catalogNo: 22,
    title: 'Ada Bakshi',
    kind: ItemKind.oralHistory,
    subtitle: 'Oral History Interview',
    description:
        'We explore the essence of Kashmir through the eyes of Ada Bakshi. '
        'From cherished customs to the breathtaking landscapes that breathe '
        'life into Kashmiri culture, Ada shares personal memories, legends, '
        'and reflections on preserving what matters most — a conversation on '
        'identity, belonging, and the enduring spirit of heritage.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '34:54',
    collectionId: 'daastan',
    caption: 'Ada Bakshi',
  ),
  ArchiveItem(
    catalogNo: 21,
    title: 'Shireen Qadri — Cofounder of Moji Masala',
    kind: ItemKind.oralHistory,
    description:
        'An oral history with Shireen Qadri, cofounder and co-CEO of Moji '
        'Masala, on entrepreneurship and Kashmiri identity.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '1:01:55',
    collectionId: 'daastan',
    caption: 'Shireen Qadri',
  ),
  ArchiveItem(
    catalogNo: 20,
    title: 'Raja Darain Khan',
    kind: ItemKind.oralHistory,
    description:
        'A psychology and philosophy student at Muhlenberg College shares his '
        'journey from Kashmir to the U.S., on identity, resilience and '
        'cultural connection.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '40:21',
    collectionId: 'daastan',
    caption: 'Raja Darain',
  ),
  ArchiveItem(
    catalogNo: 19,
    title: 'Faris Kashtwari',
    kind: ItemKind.oralHistory,
    description:
        'A 16-year-old from Srinagar living in Canada reflects on cultural '
        'preservation and Kashmiri identity.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '42:44',
    collectionId: 'daastan',
    caption: 'Faris',
  ),
  ArchiveItem(
    catalogNo: 18,
    title: 'Aimal Ali',
    kind: ItemKind.oralHistory,
    description:
        'A 12-year-old from Srinagar, now living in New Delhi, shares his '
        'perspective on cultural preservation and the essence of Kashmir.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '29:29',
    collectionId: 'daastan',
    caption: 'Aimal Ali',
  ),
  ArchiveItem(
    catalogNo: 17,
    title: 'Imaad Chowdhery & Mikael Nazir Mir',
    kind: ItemKind.oralHistory,
    description:
        'Two young Kashmiris discuss identity, cultural diversity, wildlife '
        'and the valley\'s outdoor heritage.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '22:45',
    collectionId: 'daastan',
    caption: 'Imaad & Mikael',
  ),
  ArchiveItem(
    catalogNo: 16,
    title: 'Shireen Shaw',
    kind: ItemKind.oralHistory,
    description:
        'A 15-year-old from Srinagar discusses environmental conservation and '
        'balancing development with the preservation of cultural heritage.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '35:00',
    collectionId: 'daastan',
    caption: 'Shireen Shaw',
  ),
  ArchiveItem(
    catalogNo: 12,
    title: 'YouTube Channel: Safar dar Watan',
    kind: ItemKind.movingImage,
    subtitle: 'A Journey Home',
    description:
        '"A Journey Home" explores the spirit of Kashmir, where each soul is a '
        'traveler on a journey home — preserving heritage through tales, '
        'customs and natural beauty.',
    tags: ['video', 'culture'],
    caption: 'YouTube',
  ),
  ArchiveItem(
    catalogNo: 11,
    title: 'Safar dar Watan — Spotify Podcast',
    kind: ItemKind.podcast,
    subtitle: 'A Journey Home',
    description:
        'A podcast exploring Kashmir\'s spirit, heritage, tales, customs and '
        'natural beauty through the perspectives of its guests.',
    tags: ['podcast', 'oral history'],
    caption: 'Podcast',
  ),
];

const Exhibit kNaqshExhibit = Exhibit(
  title: 'Naqsh ..... The Imprint',
  subtitle:
      'An Exhibition on Architectural Epigraphy of Kashmir (14th – 19th CE)',
  summary:
      'This exhibition showcases the surviving heritage of architectural '
      'epigraphy in Kashmir from the 14th to 19th centuries, tracing its '
      'evolution from the Sultanate period to later Afghan and Sikh rule.',
  body:
      'Featuring inscriptions in Persian, Arabic, and rare Sanskrit, it '
      'highlights the region\'s rich calligraphic traditions, their cultural '
      'significance, and their role in shaping a distinct Persianate landscape.',
  pullQuote:
      'Drawn from a detailed documentation project, the display preserves what '
      'remains of this unique fusion of art, language, and architecture.',
  tags: ['Architecture', 'Epigraphy', 'Kashmir'],
  artifacts: [
    ExhibitArtifact(
      catalogNo: 'Catalog No. 038',
      title: 'Naqsh.....The Imprint (Main View)',
      note:
          'Documentation of Sultanate-era inscriptions in Srinagar\'s historic '
          'quarter.',
      icon: Icons.account_balance,
      featured: true,
    ),
    ExhibitArtifact(
      catalogNo: 'Catalog No. 037',
      title: 'Intricate Calligraphy',
      note: '15th Century Persian Script',
      icon: Icons.draw,
    ),
    ExhibitArtifact(
      catalogNo: 'Catalog No. 036',
      title: 'Stone Carvings',
      note: 'Basalt Etchings',
      icon: Icons.landscape,
    ),
  ],
);

const List<Exhibit> kExhibits = [kNaqshExhibit];

/// Distinct, lower-cased tags across all items (for the filter row).
List<String> allItemTags() {
  final set = <String>{};
  for (final item in kItems) {
    set.addAll(item.tags);
  }
  final list = set.toList()..sort();
  return list;
}
