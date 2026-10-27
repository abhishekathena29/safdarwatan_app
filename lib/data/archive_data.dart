import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Base URL of the Omeka site the app mirrors.
const String kSiteUrl = 'https://safardarwatan.omeka.net';
const String kContributeUrl = '$kSiteUrl/contribution';
const String kContributionTermsUrl = '$kSiteUrl/contribution/terms';
const String kContactUrl = '$kSiteUrl/contact';
const String kSpotifyShowUrl =
    'https://podcasters.spotify.com/pod/show/safar-dar-watan';
const String kYouTubeChannelUrl = 'https://www.youtube.com/@safardarwatan22';

/// Photographs and stills bundled from the site (see assets/images/).
class AppImages {
  AppImages._();

  static const banner = 'assets/images/site_banner.jpg';
  static const logo = 'assets/images/site_logo.png';
  static const naqshPanel = 'assets/images/naqsh_35.jpg';
  static const naqshHankal = 'assets/images/naqsh_36.jpg';
  static const naqshPhotoWall = 'assets/images/naqsh_37.jpg';
  static const naqshInscriptions = 'assets/images/naqsh_38.jpg';
  static const ytChannel = 'assets/images/yt_channel.jpg';
  static const ytShireenQadri = 'assets/images/yt_shireen_qadri.jpg';
  static const ytHazaarDastaan = 'assets/images/yt_hazaar_dastaan.jpg';
  static const ytGyavun = 'assets/images/yt_gyavun.jpg';
  static const ytParihaspora = 'assets/images/yt_parihaspora.jpg';
  static const ytEtchings = 'assets/images/yt_etchings.jpg';
}

/// The kind of an archive item — drives the placeholder icon and label used
/// across cards when an item has no photograph.
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

/// Where an outbound [MediaLink] leads — sets its icon and verb.
enum LinkKind {
  youtube('Watch on YouTube', Icons.smart_display),
  spotify('Listen on Spotify', Icons.podcasts),
  voicethread('Listen on VoiceThread', Icons.record_voice_over),
  soundcloud('Listen on SoundCloud', Icons.graphic_eq),
  paper('Read the Paper', Icons.description),
  web('Open Link', Icons.open_in_new);

  const LinkKind(this.verb, this.icon);
  final String verb;
  final IconData icon;
}

class MediaLink {
  const MediaLink(this.kind, this.url, {this.label});

  final LinkKind kind;
  final String url;

  /// Overrides [LinkKind.verb] when set.
  final String? label;

  String get text => label ?? kind.verb;
}

/// One chapter of an interview's "Time Summary".
class OutlineEntry {
  const OutlineEntry(this.time, this.title);
  final String time;
  final String title;
}

/// A point from the site's Geolocation plugin.
class GeoPoint {
  const GeoPoint(this.lat, this.lng, this.place);
  final double lat;
  final double lng;
  final String place;
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
    this.image,
    this.date,
    this.language,
    this.interviewer,
    this.interviewee,
    this.contributors,
    this.publisher,
    this.recordedAt,
    this.links = const [],
    this.outline = const [],
    this.geo,
    this.featured = false,
  });

  /// Omeka item id (e.g. 38) — shown as "Item #38".
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

  /// Bundled asset path of the item's photograph or video still.
  final String? image;
  final String? date;
  final String? language;
  final String? interviewer;
  final String? interviewee;
  final String? contributors;
  final String? publisher;

  /// Where the recording took place (Dublin Core "Location").
  final String? recordedAt;
  final List<MediaLink> links;
  final List<OutlineEntry> outline;
  final GeoPoint? geo;
  final bool featured;

  String get siteUrl => '$kSiteUrl/items/show/$catalogNo';
}

/// A heritage collection (Omeka collection). Reuses the colour story already
/// established on the Collections screen.
class Collection {
  const Collection({
    required this.id,
    required this.omekaId,
    required this.kashmiri,
    required this.title,
    required this.description,
    required this.color,
  });

  final String id;
  final int omekaId;
  final String kashmiri;
  final String title;
  final String description;
  final Color color;

  List<ArchiveItem> get items =>
      kItems.where((i) => i.collectionId == id).toList();
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
    required this.credits,
    required this.cover,
    this.film,
  });

  final String title;
  final String subtitle;
  final String summary;
  final String body;
  final String pullQuote;
  final List<String> tags;
  final List<ExhibitArtifact> artifacts;
  final String credits;
  final String cover;

  /// The item whose video opens the exhibit's gallery page.
  final int? film;
}

/// A single plate/artifact shown inside an exhibit gallery.
class ExhibitArtifact {
  const ExhibitArtifact({
    required this.catalogNo,
    required this.title,
    required this.note,
    required this.icon,
    required this.itemId,
    this.image,
    this.featured = false,
  });

  final String catalogNo;
  final String title;
  final String note;
  final IconData icon;
  final int itemId;
  final String? image;
  final bool featured;
}

// ── Data ─────────────────────────────────────────────────────────────────
// Sourced from the safardarwatan.omeka.net REST API (extracted 2026-10-27).

const String kMission =
    'Safar Dar Watan is building an accessible digital archive that '
    'preserves and promotes Kashmir\'s historical and cultural heritage. By '
    'sharing a wide range of personal experiences and journeys, it hopes to '
    'foster community connection, inspire pride in that heritage, and show '
    'why preservation matters — using technology thoughtfully so that the '
    'legacy is available, equally and ethically, to future generations.';

const String kVision =
    'A dynamic digital tapestry that captures the spirit of Kashmir\'s '
    'cultural legacy — keeping its history, customs and geography honoured '
    'and accessible to people of every age and background. Kashmir is seen '
    'not just as a place on a map but as a timeless legacy of shared '
    'experience that builds solidarity, pride and resilience in a changing '
    'world.';

const List<Collection> kCollections = [
  Collection(
    id: 'shayari',
    omekaId: 7,
    kashmiri: 'شاعری (shayari)',
    title: 'Poetry of the Valley',
    description:
        'A curated selection of Kashmiri verse, from the mystical Vakhs of '
        'Lal Ded to contemporary resistance literature.',
    color: AppColors.poetryBlue,
  ),
  Collection(
    id: 'wupkar',
    omekaId: 6,
    kashmiri: 'وپکار (wupkar)',
    title: 'Community Outreach & Global Awareness',
    description:
        'Elevating voices that echo through the chinar trees, bridging the gap '
        'between exile and identity.',
    color: AppColors.primary,
  ),
  Collection(
    id: 'khyawun',
    omekaId: 5,
    kashmiri: 'کھیوٚن (khyawun)',
    title: 'Traditional Cuisine',
    description:
        'Wazwan and the hearth — recipes, rituals and the flavours that carry '
        'the memory of home.',
    color: AppColors.secondary,
  ),
  Collection(
    id: 'karigari',
    omekaId: 4,
    kashmiri: 'کاریگَری (kārigāri)',
    title: 'Traditional Arts & Crafts',
    description:
        'Papier-mâché, Pashmina weaving, and walnut wood carving. The hands of '
        'the masters preserved in pixels.',
    color: AppColors.tertiary,
  ),
  Collection(
    id: 'fanetaameer',
    omekaId: 3,
    kashmiri: 'فن تأمیر (Fan-e-ta\'ameer)',
    title: 'Cultural Heritage & Architecture',
    description:
        'Tracing the Sultanate, Afghan, and Sikh inscriptions on the stones of '
        'the valley. A study in stone and soul.',
    color: AppColors.onSurface,
  ),
  Collection(
    id: 'daastan',
    omekaId: 2,
    kashmiri: 'داستاں (daastan)',
    title: 'Oral Histories & Narratives',
    description:
        'Living memory — interviews and personal histories from Kashmiris at '
        'home and in the diaspora.',
    color: AppColors.onPrimaryFixedVariant,
  ),
  Collection(
    id: 'gyavun',
    omekaId: 1,
    kashmiri: 'گیوٕن (gyavun)',
    title: 'Music',
    description:
        'Melodies that carry the whispers of the mountains — evenings of song '
        'and the instruments of the valley.',
    color: AppColors.secondary,
  ),
];

const _naqshTags = ['architecture', 'exhibit', 'visual'];

const List<ArchiveItem> kItems = [
  ArchiveItem(
    catalogNo: 39,
    title: 'What is Worth Preserving in Digital Archiving?',
    kind: ItemKind.research,
    subtitle:
        'Community, Consent and an Exploration of the Psychology of Preservation',
    description:
        'A research paper on the ethics and methods of digitally archiving '
        'Kashmiri cultural heritage. Drawing on seven semi-structured '
        'interviews from the Safar Dar Watan podcast and field documentation '
        'at sacred and historic sites in Srinagar, it reads communities\' '
        'refusals to be photographed as acts of cultural self-respect, weighs '
        'tools such as AI, VR and 3D mapping, and argues for archiving as a '
        'participatory, consent-led practice.',
    tags: ['research', 'cultural heritage'],
    collectionId: 'wupkar',
    caption: 'Manuscript',
    publisher: 'IJSSRR',
    links: [
      MediaLink(LinkKind.paper,
          'https://ijssrr.com/journal/article/view/3035/2190'),
      MediaLink(
        LinkKind.web,
        'https://www.linkedin.com/posts/aania-sayida-mir-50460134a_im-pleased-to-announce-that-my-research-activity-7412501638814294017-c-1B',
        label: 'Announcement on LinkedIn',
      ),
    ],
    featured: true,
  ),
  ArchiveItem(
    catalogNo: 38,
    title: 'Naqsh.....The Imprint',
    kind: ItemKind.visual,
    subtitle: 'Inscriptions in the gallery',
    description:
        'A visitor before large-format prints of carved Persian and Arabic '
        'inscriptions at the Naqsh exhibition.',
    tags: _naqshTags,
    collectionId: 'fanetaameer',
    caption: 'Inscriptions',
    image: AppImages.naqshInscriptions,
  ),
  ArchiveItem(
    catalogNo: 37,
    title: 'Naqsh.....The Imprint',
    kind: ItemKind.visual,
    subtitle: 'A wall of mosques and shrines',
    description:
        'A wall of archival photographs documenting mosques, shrines and '
        'monuments surveyed across Kashmir for the Naqsh project.',
    tags: _naqshTags,
    collectionId: 'fanetaameer',
    caption: 'Photo wall',
    image: AppImages.naqshPhotoWall,
  ),
  ArchiveItem(
    catalogNo: 36,
    title: 'Naqsh.....The Imprint',
    kind: ItemKind.visual,
    subtitle: 'Hānkal — the curator\'s walk-through',
    description:
        'Curator Dr. Hakim Sameer Hamdani beside the "Hānkal" panel and an '
        'archival photograph of a Kashmiri shrine.',
    tags: _naqshTags,
    collectionId: 'fanetaameer',
    caption: 'Hānkal',
    image: AppImages.naqshHankal,
  ),
  ArchiveItem(
    catalogNo: 35,
    title: 'Naqsh.....The Imprint',
    kind: ItemKind.visual,
    subtitle: 'Panel discussion',
    description:
        'The exhibition\'s panel discussion, held in front of reproductions '
        'of carved inscription friezes.',
    tags: _naqshTags,
    collectionId: 'fanetaameer',
    caption: 'Panel',
    image: AppImages.naqshPanel,
  ),
  ArchiveItem(
    catalogNo: 31,
    title: 'Etchings in Stone: Voices of Kashmir\'s Architectural Epigraphy',
    kind: ItemKind.movingImage,
    subtitle: 'Short Documentary',
    description:
        'How do buildings speak? This episode explores architectural '
        'epigraphy — inscriptions carved on stone, wood and metal across '
        'Kashmir\'s built heritage — through the exhibition Naqsh… The '
        'Imprint, curated by Dr. Hakim Sameer Hamdani and his team at the '
        'School of Architecture and Planning, IUST Awantipora. Supported by '
        'a Barakat Trust conservation grant, the 2023–24 project surveyed '
        'over 600 sites and studied 41 inscriptions in depth, from mosques '
        'and shrines to bridges and mausoleums.',
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
    image: AppImages.ytEtchings,
    language: 'English',
    contributors:
        'Dr Hakim Sameer Hamdani, Mehran Qureshi, Tabish Haider Gazi, '
        'Umar Farooq, Zoya Mehraj Khan, Ta-Ha Mughal',
    links: [
      MediaLink(LinkKind.youtube, 'https://www.youtube.com/watch?v=GSTl5pzjY28'),
    ],
    geo: GeoPoint(28.5937047, 77.2226358, 'India International Centre, New Delhi'),
  ),
  ArchiveItem(
    catalogNo: 30,
    title: 'Parihaspora: The City of Laughter',
    kind: ItemKind.movingImage,
    subtitle: 'Historical Narrative',
    description:
        'A journey to Parihāsapura, the "City of Laughter" above the Vitasta '
        '(Jhelum), founded by Lalitaditya Muktapida in the mid-8th century '
        'CE. Once a capital of temples, monasteries and royal avenues '
        'recorded in Kalhaṇa\'s Rājataraṅgiṇī, it declined after the court '
        'returned to Srinagar and the river was diverted. Today only stones '
        'remain.',
    tags: ['video', 'history', 'narrative'],
    collectionId: 'fanetaameer',
    caption: 'Parihaspora',
    image: AppImages.ytParihaspora,
    date: '10 August 2025',
    language: 'English',
    publisher: 'YouTube',
    links: [
      MediaLink(LinkKind.youtube, 'https://youtube.com/shorts/p4f4zASU0dY'),
    ],
    geo: GeoPoint(34.1515195, 74.6438169, 'Parihaspora, Baramulla'),
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
    image: AppImages.ytGyavun,
    date: '5 July 2025',
    language: 'Kashmiri, with English translation',
    contributors: 'Noor Mohammad Shah',
    publisher: 'YouTube',
    links: [
      MediaLink(LinkKind.youtube, 'https://www.youtube.com/watch?v=Az642Pgx_k8'),
    ],
    geo: GeoPoint(34.0873207, 74.4499991, 'Hariwatnoo, Tangmarg'),
    featured: true,
  ),
  ArchiveItem(
    catalogNo: 23,
    title: 'Hazaar Dastaan: A Thousand Stories of Srinagar\'s Old City',
    kind: ItemKind.movingImage,
    subtitle: 'Documentary',
    description:
        'A documentary gathering stories from Srinagar\'s old city, featuring '
        'Dr Sara Khalid, Mr Shakir Mir and Ms Naveed Iqbal.',
    tags: ['documentary', 'narrative', 'culture'],
    collectionId: 'fanetaameer',
    caption: 'Old City',
    image: AppImages.ytHazaarDastaan,
    date: '14 April 2025',
    contributors: 'Dr Sara Khalid, Mr Shakir Mir, Ms Naveed Iqbal',
    publisher: 'YouTube',
    links: [
      MediaLink(LinkKind.youtube, 'https://www.youtube.com/watch?v=JgLrctG37pg'),
    ],
    geo: GeoPoint(34.0890199, 74.8011561, 'Downtown Srinagar'),
    featured: true,
  ),
  ArchiveItem(
    catalogNo: 22,
    title: 'Ada Bakshi',
    kind: ItemKind.oralHistory,
    subtitle: 'Oral History Interview',
    description:
        'The essence of Kashmir through the eyes of Ada Bakshi — cherished '
        'customs, landscapes, legends and personal memories, and what must '
        'endure for future generations. A conversation on identity, '
        'belonging and balancing tradition with change.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '34:54',
    collectionId: 'daastan',
    caption: 'Ada Bakshi',
    interviewer: 'Aania Mir',
    interviewee: 'Ada Bakshi',
    recordedAt: 'Online',
    links: [
      MediaLink(LinkKind.voicethread,
          'https://voicethread.com/app/player/?threadId=29906126'),
    ],
  ),
  ArchiveItem(
    catalogNo: 17,
    title: 'Shireen Qadri — Cofounder of Moji Masala',
    kind: ItemKind.oralHistory,
    description:
        'An oral history with Shireen Qadri, cofounder and co-CEO of Moji '
        'Masala, on entrepreneurship and Kashmiri identity.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '1:01:55',
    collectionId: 'daastan',
    caption: 'Shireen Qadri',
    image: AppImages.ytShireenQadri,
    date: '13 December 2024',
    language: 'English',
    interviewer: 'Aania Sayida Mir',
    interviewee: 'Shireen Qadri',
    recordedAt: 'Zoom',
    publisher: 'YouTube',
    links: [
      MediaLink(LinkKind.youtube, 'https://www.youtube.com/watch?v=xPrkI-oe8Yk'),
    ],
    geo: GeoPoint(39.7837304, -100.445882, 'United States'),
  ),
  ArchiveItem(
    catalogNo: 15,
    title: 'Raja Darain Khan',
    kind: ItemKind.oralHistory,
    description:
        'Raja Darain Khan — author of Oppressed to Oppressor and a psychology '
        'and philosophy student at Muhlenberg College — on his journey from '
        'Kashmir to the U.S., and on identity, resilience and cultural '
        'connection.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '40:21',
    collectionId: 'daastan',
    caption: 'Raja Darain',
    date: '3 December 2024',
    language: 'English',
    interviewer: 'Aania S Mir',
    interviewee: 'Raja Darain Khan',
    recordedAt: 'Zoom',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.spotify,
          'https://open.spotify.com/episode/1MXoJ275oZpiLoUAxQv8Wc'),
      MediaLink(LinkKind.voicethread,
          'https://voicethread.com/app/player/?threadId=29478254'),
    ],
    outline: [
      OutlineEntry('00:00', 'Introduction'),
      OutlineEntry('00:44', 'Growing up in Kashmir and the meaning of resilience'),
      OutlineEntry('08:08', 'Journey as an international student'),
      OutlineEntry('14:08', 'Discussing his book "Oppressed to Oppressor"'),
      OutlineEntry('22:08', 'Interest in clinical psychology'),
      OutlineEntry('28:13', 'Reflections and insights'),
      OutlineEntry('33:22', 'Personal growth and future aspirations'),
    ],
    geo: GeoPoint(39.7837304, -100.445882, 'United States'),
  ),
  ArchiveItem(
    catalogNo: 14,
    title: 'Faris Kashtwari',
    kind: ItemKind.oralHistory,
    description:
        'Faris Kashtwari, 16, lives in Oakville, Canada — 11,005 km from his '
        'home town, the capital of the valley. He reflects on cultural '
        'preservation, rootedness and what Kashmiri culture means to him.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '42:44',
    collectionId: 'daastan',
    caption: 'Faris',
    date: '9/11/2024',
    language: 'English',
    interviewer: 'Aania S Mir',
    interviewee: 'Faris Kashtwari',
    recordedAt: 'Zoom',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.voicethread,
          'https://voicethread.com/app/player/?threadId=29382307'),
      MediaLink(LinkKind.spotify, kSpotifyShowUrl),
    ],
    outline: [
      OutlineEntry('00:00', 'Introduction'),
      OutlineEntry('00:37', 'Personal connection to Kashmir'),
      OutlineEntry('04:28', 'Stories, customs, and heritage'),
      OutlineEntry('11:52', 'Preservation and conservation'),
      OutlineEntry('18:22', 'Exploring the natural and cultural landscape'),
      OutlineEntry('23:19', 'Journey and discovery'),
      OutlineEntry('26:58', 'Cultural essence and its challenges'),
      OutlineEntry('30:56', 'Perspective and preservation'),
      OutlineEntry('34:26', 'Cultural exchange and impact'),
      OutlineEntry('38:22', 'The importance of heritage'),
    ],
    geo: GeoPoint(43.447436, -79.666672, 'Oakville, Canada'),
  ),
  ArchiveItem(
    catalogNo: 11,
    title: 'Aimal Ali',
    kind: ItemKind.oralHistory,
    description:
        'Aimal Ali, 12, originally from Srinagar and now living in New Delhi, '
        'shares her perspective on cultural preservation and the essence of '
        'Kashmir.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '29:29',
    collectionId: 'daastan',
    caption: 'Aimal Ali',
    date: '2 November 2024',
    language: 'English, Hindi, Urdu, Kashmiri',
    interviewer: 'Aania Sayida Mir',
    interviewee: 'Aimal Ali',
    recordedAt: 'Zoom',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.spotify,
          'https://podcasters.spotify.com/pod/show/safar-dar-watan/episodes/Aimal-Ali-e2qf0vb'),
      MediaLink(LinkKind.soundcloud, 'https://soundcloud.com/safar-dar-watan'),
    ],
    outline: [
      OutlineEntry('00:00', 'Introduction'),
      OutlineEntry('00:37', 'Personal connection to Kashmir'),
      OutlineEntry('02:51', 'Stories, customs, and heritage'),
      OutlineEntry('08:06', 'Exploring the natural and cultural landscape'),
      OutlineEntry('12:02', 'Preservation and conservation'),
      OutlineEntry('16:27', 'Journey and discovery'),
      OutlineEntry('17:47', 'Perspective and preservation'),
      OutlineEntry('20:59', 'Cultural essence and its challenges'),
      OutlineEntry('23:52', 'Cultural exchange and impact'),
      OutlineEntry('26:42', 'The importance of heritage'),
    ],
    geo: GeoPoint(28.6138954, 77.2090057, 'New Delhi'),
  ),
  ArchiveItem(
    catalogNo: 10,
    title: 'Imaad Chowdhery & Mikael Nazir Mir',
    kind: ItemKind.oralHistory,
    description:
        'Imaad Chowdhery, 17, and Mikael Nazir Mir, 11, live in Delhi but stay '
        'deeply connected to their roots. Imaad speaks about his Pahadi and '
        'Gujari identity and the diversity of Kashmiri culture; Mikael about '
        'the valley\'s wildlife and outdoor adventures, from skiing to '
        'heritage.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '22:45',
    collectionId: 'daastan',
    caption: 'Imaad & Mikael',
    date: '24 October 2024',
    language: 'English, Urdu, Kashmiri, Hindi',
    interviewer: 'Aania Sayida Mir',
    interviewee: 'Imaad Chowdhery and Mikael Nazir Mir',
    recordedAt: 'New Delhi',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.spotify,
          'https://open.spotify.com/episode/5ZWxPgOzFz0IiYoC5EVD94'),
      MediaLink(LinkKind.soundcloud, 'https://soundcloud.com/safar-dar-watan'),
    ],
    geo: GeoPoint(28.5292495, 77.1541335, 'Vasant Kunj, New Delhi'),
  ),
  ArchiveItem(
    catalogNo: 9,
    title: 'Shireen Shaw',
    kind: ItemKind.oralHistory,
    description:
        'Shireen Shaw, 15, from Srinagar and studying in New Delhi, on '
        'environmental conservation in Kashmir and balancing development with '
        'the preservation of cultural heritage. An avid horse rider and '
        'trekker, she reflects on the valley\'s natural beauty and her hopes '
        'for its future.',
    tags: ['culture', 'narrative', 'personal history', 'story'],
    duration: '35:00',
    collectionId: 'daastan',
    caption: 'Shireen Shaw',
    date: '31 October 2024',
    language: 'English, Urdu, Kashmiri, Hindi',
    interviewer: 'Aania Sayida Mir',
    interviewee: 'Shireen Shaw',
    recordedAt: 'Zoom',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.spotify,
          'https://open.spotify.com/episode/3IinrUtr0JoAWk7yLnd54T'),
    ],
    geo: GeoPoint(28.6138954, 77.2090057, 'New Delhi'),
  ),
  ArchiveItem(
    catalogNo: 16,
    title: 'YouTube Channel: Safar dar Watan',
    kind: ItemKind.movingImage,
    subtitle: 'A Journey Home',
    description:
        '"A Journey Home" explores the spirit of Kashmir, where each soul is a '
        'traveller on a journey home — preserving heritage through tales, '
        'customs and natural beauty.',
    tags: ['video', 'culture'],
    caption: 'YouTube',
    image: AppImages.ytChannel,
    date: '13 December 2024',
    publisher: 'YouTube',
    links: [
      MediaLink(LinkKind.youtube, 'https://www.youtube.com/watch?v=0JiE3pKCl-A'),
      MediaLink(LinkKind.web, kYouTubeChannelUrl, label: 'Open the Channel'),
    ],
    featured: true,
  ),
  ArchiveItem(
    catalogNo: 8,
    title: 'Safar dar Watan — Spotify Podcast',
    kind: ItemKind.podcast,
    subtitle: 'A Journey Home',
    description:
        'A podcast exploring Kashmir\'s spirit, heritage, tales, customs and '
        'natural beauty. Each guest takes their own route through the journey '
        '— asking what matters, what is at stake, and what it means to '
        'preserve our heritage.',
    tags: ['podcast', 'oral history'],
    collectionId: 'daastan',
    caption: 'Podcast',
    image: AppImages.ytChannel,
    language: 'English, Hindi, Urdu, Kashmiri',
    contributors:
        'Imaad Chowdhery, Mikael Nazir Mir, Shireen Shaw, Aimal Ali, '
        'Faris Kashtwari, Raja Darain Khan',
    publisher: 'Spotify',
    links: [
      MediaLink(LinkKind.spotify, kSpotifyShowUrl),
    ],
    featured: true,
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
  credits:
      'Sameer Hamdani, Mehran Qureshi, Tabish Haider Gazi, Umar Farooq, '
      'Zoya Mehraj Khan and Ta-Ha Mughal',
  cover: AppImages.naqshInscriptions,
  film: 31,
  artifacts: [
    ExhibitArtifact(
      catalogNo: 'Catalog No. 038',
      title: 'Inscriptions in the Gallery',
      note: 'Large-format prints of carved Persian and Arabic inscriptions.',
      icon: Icons.account_balance,
      itemId: 38,
      image: AppImages.naqshInscriptions,
      featured: true,
    ),
    ExhibitArtifact(
      catalogNo: 'Catalog No. 037',
      title: 'A Wall of Mosques and Shrines',
      note: 'Archival photographs of the sites surveyed.',
      icon: Icons.photo_library,
      itemId: 37,
      image: AppImages.naqshPhotoWall,
    ),
    ExhibitArtifact(
      catalogNo: 'Catalog No. 035',
      title: 'Panel Discussion',
      note: 'Conversations before the inscription friezes.',
      icon: Icons.forum,
      itemId: 35,
      image: AppImages.naqshPanel,
    ),
    ExhibitArtifact(
      catalogNo: 'Catalog No. 036',
      title: 'Hānkal',
      note: 'The curator\'s walk-through.',
      icon: Icons.link,
      itemId: 36,
      image: AppImages.naqshHankal,
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

ArchiveItem? itemById(int id) {
  for (final item in kItems) {
    if (item.catalogNo == id) return item;
  }
  return null;
}

Collection? collectionById(String? id) {
  for (final c in kCollections) {
    if (c.id == id) return c;
  }
  return null;
}

List<ArchiveItem> get featuredItems =>
    kItems.where((i) => i.featured).toList();

List<ArchiveItem> get geolocatedItems =>
    kItems.where((i) => i.geo != null).toList();
