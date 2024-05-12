import 'package:flutter/material.dart';

class HiringScreen extends StatefulWidget {
  const HiringScreen({Key? key}) : super(key: key);

  @override
  _HiringScreenState createState() => _HiringScreenState();
}

class _HiringScreenState extends State<HiringScreen> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiring'),
      ),
      body: Column(
        children: [
          // Navbar with buttons/options
          Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF01696E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavbarButton('Delivery', 0),
                _buildNavbarButton('Rider', 1),
                _buildNavbarButton('Cook', 2),
                // Add more buttons as needed
              ],
            ),
          ),

          // Spacer
          SizedBox(height: 10),
          // List of cards with gigs
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount:
                  3, // Assuming you have 3 categories (Delivery, Rider, Cook)
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                if (index == _selectedButtonIndex) {
                  // Load cards based on the selected button
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: ListTile(
                          title: Text('Gig Title 1'),
                          subtitle: Text('Description of the gig 1'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add functionality to hire for this gig
                            },
                            child: Text('Hire Me'),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Gig Title 2'),
                          subtitle: Text('Description of the gig 2'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add functionality to hire for this gig
                            },
                            child: Text('Hire Me'),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Gig Title 3'),
                          subtitle: Text('Description of the gig 3'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add functionality to hire for this gig
                            },
                            child: Text('Hire Me'),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Gig Title 4'),
                          subtitle: Text('Description of the gig 4'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add functionality to hire for this gig
                            },
                            child: Text('Hire Me'),
                          ),
                        ),
                      ),
                      // Add more cards as needed
                    ],
                  );
                } else {
                  // Return an empty container for non-selected categories
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbarButton(String text, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            _selectedButtonIndex = index;
          });
        },
        color: _selectedButtonIndex == index
            ? Colors.blue
            : const Color(0xFF01696E),
        hoverColor: Colors.blue.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          // side: BorderSide(color: Colors.blue),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedButtonIndex == index
                ? Colors.white
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
