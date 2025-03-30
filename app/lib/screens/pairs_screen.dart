import 'package:flutter/material.dart';

class PairsScreen extends StatefulWidget {
  @override
  _PairsScreenState createState() => _PairsScreenState();
}

class _PairsScreenState extends State<PairsScreen> {
  final String user1Name = "Alice";
  final String user2Name = "Bob";
  final String user1ImageUrl =
      "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"; // Replace with actual image URL
  final String user2ImageUrl =
      "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg"; // Replace with actual image URL

  double _rating = 3.0; // Default rating value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        backgroundColor: Colors.blue, // AppBar color
        elevation: 0, // Remove shadow under AppBar
        toolbarHeight: 0, // Remove AppBar height completely
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 32.0), // Reduced padding on sides
        child: Column(
          children: [
            // User profile images and details (without the title)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildUserProfile(user1ImageUrl, user1Name, context),
                  const SizedBox(width: 10), // Reduced spacing between images
                  _buildUserProfile(user2ImageUrl, user2Name, context),
                ],
              ),
            ),

            // Sticky slider with left and right buttons
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0), // Bottom padding for the buttons
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(Icons.close, Colors.red, "Reject"),
                    const SizedBox(width: 20),
                    _buildActionButton(
                        Icons.check, Colors.green, "Accept", context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display a user profile with an image and name below it
  Widget _buildUserProfile(String imageUrl, String name, BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15), // Rounded corners
          child: Image.network(
            imageUrl,
            width:
                MediaQuery.of(context).size.width * 0.4, // 40% of screen width
            height: MediaQuery.of(context).size.height *
                0.4, // 40% of screen height
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors
                .black, // Text color to contrast with the white background
          ),
        ),
      ],
    );
  }

  // Widget to build the left (reject) and right (accept) action buttons
  Widget _buildActionButton(IconData icon, Color color, String label,
      [BuildContext? context]) {
    return ElevatedButton(
      onPressed: () {
        // Handle action (accept/reject)
        if (label == "Accept" && context != null) {
          _showRatingDialog(
              context); // Show the rating dialog when the user presses "Accept"
        } else {
          print("$label pressed");
        }
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
      ),
      child: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  // Function to show the rating dialog
  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rate Compatibility"),
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Please rate your compatibility from 1 to 5"),
                  Slider(
                    value: _rating,
                    min: 1.0,
                    max: 5.0,
                    divisions: 4, // Creates 4 steps between the values 1 and 5
                    label: _rating.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _rating = value; // Update the rating value dynamically
                      });
                    },
                  ),
                  Text(
                    "Rating: $_rating",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                print("Rated compatibility: $_rating");
                Navigator.pop(
                    context); // Close the dialog after submitting the rating
              },
              child: const Text("Submit Rating"),
            ),
          ],
        );
      },
    );
  }
}
