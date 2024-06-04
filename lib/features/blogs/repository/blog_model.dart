class Blog {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String author;
  final String date;
  final String authorImageUrl;

  Blog({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.author,
    required this.date,
    required this.authorImageUrl,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      category: json['category'],
      author: json['author'],
      date: json['date'],
      authorImageUrl: json['author_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'category': category,
      'author': author,
      'date': date,
      'author_image_url': authorImageUrl,
    };
  }
}

final List<Blog> blogs = [
 Blog(
      title: 'The essence of competition',
      description: 'Reflecting on the nature of competition and its impact',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdcvEtyvA1_41rCmcPHOw2FAuqXmlwR8ftJQ&s',
      category: 'Sports',
      author: 'David Wilson',
      date: '2022-02-28',
      authorImageUrl:
          'https://s.yimg.com/ny/api/res/1.2/JjavC4y9TFdsw9owJgvvpg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTQ2OQ--/https://media.zenfs.com/en/the_cool_down_737/5e9dae7d0b7489467a55688bfa006b3b'),
  Blog(
      title: 'Achieving peak performance',
      description: 'Strategies for reaching your maximum athletic potential',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROs5mrdZVoY-x2R6hiS1tEvjQuudXGfxUtMw&s',
      category: 'Sports',
      author: 'Sarah Thompson',
      date: '2022-03-12',
      authorImageUrl:
          'https://pngfre.com/wp-content/uploads/Mr-Bean-26-724x1024.png'),
  Blog(
      title: 'The art of coaching',
      description:
          'Insights into effective coaching techniques and philosophies',
      imageUrl: 'https://assets-us-01.kc-usercontent.com/469992e5-7cbd-0032-ead4-f2db9237053a/53f35553-7dbd-4e10-aa80-3b54458ed0ed/2021-03-24_social_coaching-competencies-for-managers-must-have-skills.jpg',
      category: 'Sports',
      author: 'Alex Miller',
      date: '2022-04-07',
      authorImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBh1Bjt2U5K-53Kwx7SFwwxwlCH_ihN0wvEQ&s'),
  Blog(
      title: 'Injuries in sports: Prevention and recovery',
      description: 'Tips for avoiding injuries and managing recovery in sports',
      imageUrl: 'https://assets-us-01.kc-usercontent.com/469992e5-7cbd-0032-ead4-f2db9237053a/a78006f8-d80c-4d30-8c2e-bff9122faa74/2022-04-27_why-your-company-needs-a-coaching-culture.jpg',
      category: 'Sports',
      author: 'Jessica Lee',
      date: '2022-05-19',
      authorImageUrl:
          'https://lumiere-a.akamaihd.net/v1/images/character_themuppets_kermit_b77a431b.jpeg'),
  Blog(
      title: 'Sports and mental health',
      description:
          'Exploring the connection between sports participation and mental well-being',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwQPU8uiNyh41HsZFCtbtrb1Pysn7PPOBEQQ&s',
      category: 'Sports',
      author: 'Matthew Davis',
      date: '2022-06-25',
      authorImageUrl:
          'https://cdn.musebycl.io/2021-03/Kermit-The-Frog-adidas-Stan-Smith-hed-2021.jpg'),
  Blog(
      title: 'The evolution of sports technology',
      description: 'Examining the impact of technology on modern sports',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRBISTIVIEkZCvdi94PXrsf5bKahSUmydwjA&s',
      category: 'Sports',
      author: 'William Garcia',
      date: '2022-08-03',
      authorImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBh1Bjt2U5K-53Kwx7SFwwxwlCH_ihN0wvEQ&s')
];
