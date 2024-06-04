import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modawan/core/theme/theme_constants.dart';
import 'package:modawan/core/widgets/components/custom_containers.dart';
import 'package:modawan/core/widgets/components/modawan_logo.dart';
import 'package:modawan/features/blogs/repository/blog_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> topics = [
    'Technology',
    'Science',
    'Health',
    'Business',
    'Entertainment lsdkfjlskdjfls',
    'Sports',
    'Politics',
    'Fashion',
    'Travel',
    'Education skdljf',
    'Food',
    'Lifestyle',
    'Culture',
    'Art',
    'Environment sdklfj',
    'Music',
    'Film',
    'Books',
    'Theatre',
    'TV',
    'Radio',
    'Dance',
    'Comedy',
    'Games',
    'Puzzles',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.1;
    return GradientContainer(
        child: Scaffold(
      //put gradient color as background
      backgroundColor: Colors.transparent,
      // app bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height), // here the desired height
        child: CustomAappBar(height: height),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // add carousel here
          TopicsBar(topics: topics),
          const SizedBox(height: 40),
          CarouselSlider(
              items: _buildBlogs(blogs),
              options: CarouselOptions(
                clipBehavior: Clip.none,
                height: 500,
                aspectRatio: 16 / 9,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 1800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                scrollDirection: Axis.horizontal,
              )),
          // add news list here
        ],
      ),
    ));
  }
}

List<Widget> _buildBlogs(List<Blog> blogs) {
  List<Widget> newsWidgets = blogs.map((blog) {
    return BlogVCard(blog: blog);
  }).toList();
  return newsWidgets;
}

class BlogVCard extends StatelessWidget {
  const BlogVCard({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.darkblue.withOpacity(0.01),
            border: Border.symmetric(
                horizontal: BorderSide(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.1)))),
        child: Column(
          children: [
            Image.network(blog.imageUrl),
            Text(blog.title),
            Text(blog.description),
            Text(blog.author),
            Text(blog.date),
          ],
        ),
      ),
    );
  }
}

class TopicsBar extends StatelessWidget {
  const TopicsBar({
    super.key,
    required this.topics,
  });

  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.darkblue.withOpacity(0.01),
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0)
                      .withOpacity(0.1)))),
      child: CarouselSlider(
          items: _buildTopics(topics),
          options: CarouselOptions(
            clipBehavior: Clip.none,
            height: 40,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 3000),
            autoPlayCurve: Curves.linear,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 16 / 16,
            viewportFraction: 0.32,
            initialPage: 0,
            reverse: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {},
          )),
    );
  }
}

List<Widget> _buildTopics(List<String> topics) {
  List<Widget> topicWidgets = topics.map((name) {
    return TopicButton(topic: name);
  }).toList();
  return topicWidgets;
}

class TopicButton extends StatelessWidget {
  const TopicButton({
    super.key,
    required this.topic,
  });
  final String topic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to search page
      },
      child: GlassContainer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppTextStyles.buttontextstyle
                  .copyWith(fontWeight: FontWeight.w500),
              topic,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAappBar extends StatelessWidget {
  const CustomAappBar({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.glasscolor,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: AppColors.darkblue,
              iconSize: 30,
            ),
            ModawanLogo(
              color: AppColors.darkblue,
              width: height - 20, // padding is 10 top and bottom
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: AppColors.darkblue,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
