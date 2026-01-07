import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:custom_dots_indicator/custom_dots_indicator.dart';
import 'package:flutter/material.dart';

final ScrollController _scrollController = ScrollController();

class PromosWidget extends StatelessWidget {
  final List promos;



  const PromosWidget({
    super.key, required this.promos,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 126,
      child: Column(
        children: [
          SizedBox(
            height: 106,
            child: ListView.separated(
              controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 242,
                    height: 106,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex(promos[index]["color"]),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(width: 120,
                                child: Text(promos[index]["title"],
                                  style: Theme.of(context,)
                                      .textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(100),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Text("${promos[index]["save"]}-",
                                  style: Theme.of(context,)
                                      .textTheme.bodyMedium?.copyWith(

                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10,);
                },
                itemCount: promos.length
            ),
          ),
          const SizedBox(height: 10),
          // 3. Add the sync-indicator
          SizedBox(
            height: 10,
            child: CustomDotsIndicator(
              controller: _scrollController,
              listLength: promos.length, // Total number of items in your list
              dotsCount: promos.length,   // Number of dots to display
              activeDotColor: Colors.grey[600],
              inactiveDotColor: Colors.grey[300]!,
            ),
          ),
        ],
      ),
    );
  }
}


class ShimmerPromoWidget extends StatefulWidget {
  const ShimmerPromoWidget({super.key});

  @override
  _ShimmerPromoWidgetState createState() => _ShimmerPromoWidgetState();
}

class _ShimmerPromoWidgetState extends State<ShimmerPromoWidget>
    with SingleTickerProviderStateMixin { // required for the AnimationController
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.2, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SizedBox(
        height: 126,
        child: Column(
          children: [


            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 242,
                    height: 106,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 10),
            // 3. Add the sync-indicator
            SizedBox(
              height: 10,
              child: CustomDotsIndicator(
                controller: _scrollController,
                listLength: 2, // Total number of items in your list
                dotsCount: 2,   // Number of dots to display
                activeDotColor: Colors.grey[600],
                inactiveDotColor: Colors.grey[300]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


