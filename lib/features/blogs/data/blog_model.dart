class BlogModel {
  final int id;
  final String title;
  final String description;
  final String? mainImageUrl;
  final String authorId;
  final String date;
  final String content;
  final bool isPublished;

  BlogModel({
    required this.id,
    required this.title,
    required this.description,
    this.mainImageUrl,
    required this.authorId,
    required this.date,
    required this.content,
    required this.isPublished,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      mainImageUrl: json['main_image'],
      authorId: json['author'],
      date: json['created_at'],
      content: json['content'],
      isPublished: json['is_published'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_published': isPublished,
      'title': title,
      'description': description,
      'main_image': mainImageUrl,
      'author': authorId,
      'date': date,
    };
  }
}

// final List<BlogModel> blogs = [
//   BlogModel(
//       id: '1',
//       isPublished: true,
//       title: 'The essence of competition',
//       description: 'Reflecting on the nature of competition and its impact',
//       mainImageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdcvEtyvA1_41rCmcPHOw2FAuqXmlwR8ftJQ&s',
//       authorId: 'David Wilson',
//       date: '2022-02-28',
//       content:
//           'https://s.yimg.com/ny/api/res/1.2/JjavC4y9TFdsw9owJgvvpg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTQ2OQ--/https://media.zenfs.com/en/the_cool_down_737/5e9dae7d0b7489467a55688bfa006b3b'),
//   BlogModel(
//       id: '2',
//       isPublished: true,
//       title: 'Achieving peak performance',
//       description: 'Strategies for reaching your maximum athletic potential',
//       mainImageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROs5mrdZVoY-x2R6hiS1tEvjQuudXGfxUtMw&s',
//       authorId: 'Sarah Thompson',
//       date: '2022-03-12',
//       content: 'https://pngfre.com/wp-content/uploads/Mr-Bean-26-724x1024.png'),
//   BlogModel(
//       id: '3',
//       isPublished: true,
//       title: 'The art of coaching',
//       description:
//           'Insights into effective coaching techniques and philosophies',
//       mainImageUrl:
//           'https://assets-us-01.kc-usercontent.com/469992e5-7cbd-0032-ead4-f2db9237053a/53f35553-7dbd-4e10-aa80-3b54458ed0ed/2021-03-24_social_coaching-competencies-for-managers-must-have-skills.jpg',
//       authorId: 'Alex Miller',
//       date: '2022-04-07',
//       content:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBh1Bjt2U5K-53Kwx7SFwwxwlCH_ihN0wvEQ&s'),
//   BlogModel(
//       id: '4',
//       isPublished: true,
//       title: 'Injuries in sports: Prevention and recovery',
//       description: 'Tips for avoiding injuries and managing recovery in sports',
//       mainImageUrl:
//           'https://assets-us-01.kc-usercontent.com/469992e5-7cbd-0032-ead4-f2db9237053a/a78006f8-d80c-4d30-8c2e-bff9122faa74/2022-04-27_why-your-company-needs-a-coaching-culture.jpg',
//       authorId: 'Jessica Lee',
//       date: '2022-05-19',
//       content:
//           'https://lumiere-a.akamaihd.net/v1/images/character_themuppets_kermit_b77a431b.jpeg'),
//   BlogModel(
//       id: '5',
//       isPublished: true,
//       title: 'Sports and mental health',
//       description:
//           'Exploring the connection between sports participation and mental well-being',
//       mainImageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwQPU8uiNyh41HsZFCtbtrb1Pysn7PPOBEQQ&s',
//       authorId: 'Matthew Davis',
//       date: '2022-06-25',
//       content:
//           'https://cdn.musebycl.io/2021-03/Kermit-The-Frog-adidas-Stan-Smith-hed-2021.jpg'),
//   BlogModel(
//       id: '6',
//       isPublished: true,
//       title: 'The evolution of sports technology',
//       description: 'Examining the impact of technology on modern sports',
//       mainImageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRBISTIVIEkZCvdi94PXrsf5bKahSUmydwjA&s',
//       authorId: 'William Garcia',
//       date: '2022-08-03',
//       content:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBh1Bjt2U5K-53Kwx7SFwwxwlCH_ihN0wvEQ&s')
// ];
