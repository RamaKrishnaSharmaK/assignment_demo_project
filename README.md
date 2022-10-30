
Here is the attached JSON file where it contains list of the products with title, description, and quantity

The following functionalities must be implemented:

Product listing and search page
Create a page for listing the products (reading from the JSON file provided).
Each item in list view should display title, description, and quantity
On the same page implement a search bar on the top
Search bar should filter the records in the listing as user starts entering the keys.
Search an item by using title or description
Notifications and timer
After opening the app, every one minute reduce the quantity of any item by 1
You must choose items randomly for reducing the quantity 
You can maintain a timer internally in application for counting 1 minute 
After every minute, the reduced quantity should reflect in product listing 
Show notification every minute when the quantity is reduced in notification bar 
Notification should read “Only <Quantity> <product name>< available now>”

Implementation Guidelines 
Read JSON file using serialization with JSON encode and decoding
Use singleton pattern to store and retrieve JSON file
Any state management pattern would be fine  


# assignment_demo_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
