# 🍴 FoodiFy – Multi-Vendor Food Ordering App

### 📘 Internship Details

- **Internship:** Mobile App Development with Flutter
- **Team:** MAD Team 17
- **Submission Week:** Week 1 – App Proposal, Wireframes & GitHub Repository

---

## 1. 📱 App Title and Overview

**App Name:** FoodiFy

**Executive Summary:**  
FoodiFy is a multi-vendor food ordering application designed to connect users with a variety of food vendors through a single digital platform.  
The app enables customers to browse restaurants, customize orders, and track deliveries in real time, while vendors manage menus, pricing, and orders seamlessly.  
By combining a modern, user-friendly interface with a scalable backend, FoodiFy aims to enhance convenience, vendor visibility, and food-ordering efficiency.

---

## 2. 🎯 Purpose and Objectives

**Purpose:**  
To create a reliable and efficient digital solution that simplifies the process of ordering and delivering food for customers and restaurants.

**Objectives:**

- Design an intuitive and attractive Flutter UI for seamless user interaction
- Implement navigation and authentication features for both users and admins
- Establish a backend system for restaurant data, orders, and delivery tracking
- Ensure responsive layouts compatible with Android and iOS devices
- Integrate push notifications and order updates for real-time communication

---

## 3. 👥 Target Users

- **Customers (Learners):** Users who browse available restaurants, view menus, place orders, and track deliveries.
- **Admins:** Restaurant or platform managers who add menu items, confirm orders, assign deliveries, and manage data.

---

## 4. 🧩 Key Features

| Feature                        | Description                                              |
| ------------------------------ | -------------------------------------------------------- |
| **User Authentication**        | Secure signup and login using email/password             |
| **Restaurant Listing**         | Browse a list of restaurants and cuisines                |
| **Menu & Cart System**         | Add/remove food items to/from the shopping cart          |
| **Order Placement & Tracking** | Place orders and view real-time delivery progress        |
| **Admin Dashboard**            | Manage restaurants, menus, and incoming orders           |
| **Push Notifications**         | Receive updates about order confirmations and deliveries |

---

## 5. 🚶‍♂️ User Journey Examples

### **Customer Journey**

1. Opens FoodiFy app → Logs in or signs up
2. Browses available restaurants → Selects a meal
3. Adds items to cart → Proceeds to checkout
4. Confirms payment → Tracks delivery in real time

### **Admin Journey**

1. Logs in as admin → Views incoming orders
2. Assigns orders to available delivery staff
3. Updates order and delivery status
4. Manages restaurant listings and menu data

---

## 6. 🖼️ Wireframe & Design

Explore the complete wireframe design in Figma:  
🔗 [View Figma Wireframe](https://www.figma.com/design/JWTBebXe0ZrYM0WlPyHbT8/Food-Vender-Application?node-id=0-1&t=PBx9epyLOCvVAZ12-1)

---

## 7. 📄 Project Proposal Document

For the full project proposal (objectives, user roles, and app concept), view the document here:  
📘 [View App Proposal Document](App%20Proposal%20Document.pdf)

---

## 8. 💻 GitHub Repository

Access the full project repository here:  
🔗 https://github.com/mahrukhkamalcs/Foodify-/edit/main

---

## 9. ✅ Development Progress

### **What We've Accomplished:**

#### **Week 1 - UI Implementation & Architecture Setup**

✅ **Core UI Screens Developed:**

- **Home Screen** - Complete with restaurant listings, daily deals banner, category filters, and trending dishes
- **Restaurant Details Screen** - Menu display with categories, item descriptions, and add-to-cart functionality
- **Search Screen** - Search interface for restaurants and dishes
- **Orders Screen** - Order history and tracking interface
- **Profile Screen** - User profile with settings, addresses, payment methods, and logout

✅ **Reusable Component Library:**

- Custom buttons (Primary, Secondary, Icon buttons)
- Themed text fields and search bars
- Card components with shadows and rounded corners
- Bottom navigation bar with smooth transitions
- Category chips and filters
- Restaurant and menu item cards

✅ **Design System Implementation:**

- Color palette: Orange (#FF7A00), Yellow (#FFD54F), Green (#4CAF50)
- Typography system using Poppins and Inter fonts
- Consistent spacing and padding using dimension constants
- Material 3 design principles with custom theming

✅ **Navigation & User Flow:**

- Bottom navigation with 4 main tabs (Home, Search, Orders, Profile)
- Smooth page transitions between screens
- Restaurant details navigation from home screen
- Cart overlay system

---

## 10. 📁 Current Folder Structure

```
    📦lib
 ┣ 📂core                              # Shared foundation code
 ┃ ┣ 📂theme                           # App-wide styling
 ┃ ┃ ┣ 📜app_colors.dart              # Color palette (#FF7A00, #FFD54F, #4CAF50)
 ┃ ┃ ┣ 📜app_text_styles.dart         # Typography (Poppins, Inter fonts)
 ┃ ┃ ┗ 📜app_theme.dart               # Material theme configuration
 ┃ ┣ 📂utils                           # Utility functions & constants
 ┃ ┃ ┣ 📜app_dimensions.dart          # Spacing, padding, radius values (8dp, 16dp, 24dp)
 ┃ ┃ ┗ 📜constants.dart               # App-wide constant values
 ┃ ┗ 📂widgets                         # Reusable UI components
 ┃ ┃ ┣ 📂buttons
 ┃ ┃ ┃ ┗ 📜primary_button.dart        # Orange rounded button component
 ┃ ┃ ┗ 📂inputs
 ┃ ┃ ┃ ┗ 📜custom_text_field.dart     # Styled text input field
 ┃
 ┣ 📂data                              # Data layer
 ┃ ┗ 📂models                          # Data models (DTOs)
 ┃ ┃ ┗ 📂restaurant
 ┃ ┃ ┃ ┣ 📜category_model.dart        # Food category data structure
 ┃ ┃ ┃ ┣ 📜menu_item_model.dart       # Menu item with price, description
 ┃ ┃ ┃ ┗ 📜restaurant_model.dart      # Restaurant info, rating, delivery time
 ┃
 ┣ 📂features                          # Feature modules (UI layer)
 ┃ ┣ 📂auth                           # Authentication
 ┃ ┃ ┗ 📜signup_screen.dart           # User registration screen
 ┃ ┣ 📂cart                           # Shopping cart (to be implemented)
 ┃ ┣ 📂home                           # Home screen feature
 ┃ ┃ ┣ 📂screens
 ┃ ┃ ┃ ┗ 📜home_screen.dart           # Main home screen with restaurant listings
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜category_chip.dart         # Category filter chip (Pizza, Burgers, etc.)
 ┃ ┃ ┃ ┣ 📜category_section.dart      # Horizontal scrollable category list
 ┃ ┃ ┃ ┣ 📜daily_deals_banner.dart    # Promotional banner with gradient
 ┃ ┃ ┃ ┣ 📜home_search_bar.dart       # Search bar with filter button
 ┃ ┃ ┃ ┗ 📜restaurant_card.dart       # Restaurant display card
 ┃ ┣ 📂onboarding
 ┃ ┃ ┗ 📜onboarding_screen.dart       # App introduction slides
 ┃ ┣ 📂orders                         # Order management
 ┃ ┃ ┗ 📂screens
 ┃ ┃ ┃ ┗ 📜orders_screen.dart         # Order history and status
 ┃ ┣ 📂order_tracking                 # Live order tracking (to be implemented)
 ┃ ┣ 📂profile                        # User profile
 ┃ ┃ ┣ 📂screens
 ┃ ┃ ┃ ┗ 📜profile_screen.dart        # User profile with settings menu
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜profile_header.dart        # Avatar and user info display
 ┃ ┃ ┃ ┗ 📜profile_menu_item.dart     # Menu item (Orders, Addresses, Settings)
 ┃ ┣ 📂restaurant                     # Restaurant details
 ┃ ┃ ┣ 📂screens
 ┃ ┃ ┃ ┗ 📜restaurant_details_screen.dart  # Restaurant menu and info
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜menu_category_tabs.dart    # Menu category tabs (Popular, Appetizers)
 ┃ ┃ ┃ ┣ 📜menu_item_tile.dart        # Individual menu item with add button
 ┃ ┃ ┃ ┣ 📜restaurant_banner.dart     # Restaurant banner with back/favorite buttons
 ┃ ┃ ┃ ┣ 📜restaurant_info.dart       # Restaurant name, rating, delivery info
 ┃ ┃ ┃ ┗ 📜view_cart_bar.dart         # Sticky "Add to Cart" bottom bar
 ┃ ┗ 📂search                         # Search functionality
 ┃ ┃ ┗ 📂screens
 ┃ ┃ ┃ ┗ 📜search_screen.dart         # Search restaurants and dishes
 ┃
 ┣ 📂models                            # Additional models (if needed)
 ┣ 📂navigation                        # Navigation management
 ┃ ┣ 📜bottom_nav_bar.dart            # Bottom navigation bar component
 ┃ ┗ 📜main_navigation.dart           # Screen switching controller
 ┣ 📂services                          # API services (to be implemented)
 ┗ 📜main.dart                         # App entry point


 assets/                            # Asset files (outside lib/)
├── images/
│   ├── logo/
│   ├── onboarding/
│   ├── restaurants/
│   └── food/
└── fonts/
    ├── Poppins/
    └── Inter/
```

### **📂 Architecture Explanation**

#### **1. `core/` - Foundation Layer**

**Purpose:** Contains shared code used across the entire application

- **`theme/`** - Centralized design system
  - Colors, typography, and Material theme settings
  - Ensures consistent look and feel throughout the app
  - Uses warm color palette: Orange (#FF7A00), Yellow (#FFD54F), Green (#4CAF50)
- **`utils/`** - Helper functions and constants
  - `app_dimensions.dart`: Standardized spacing using 8dp grid system
  - `constants.dart`: App-wide constant values (API URLs, keys, etc.)
- **`widgets/`** - Reusable UI components
  - Contains components used in multiple features
  - Currently: buttons and input fields
  - Follows atomic design principles

**Benefits:**

- ✅ Single source of truth for styling
- ✅ Consistent UI across all screens
- ✅ Easy to update theme globally
- ✅ Reusable components reduce code duplication

---

#### **2. `data/` - Data Layer**

**Purpose:** Handles data structures and business models

- **`models/restaurant/`** - Restaurant-related data structures
  - `category_model.dart`: Food categories (Pizza, Burgers, Desserts, etc.)
  - `menu_item_model.dart`: Menu items with prices, descriptions, images
  - `restaurant_model.dart`: Restaurant information (name, rating, delivery time)

**Future Additions:**

- `models/user/` - User profiles and authentication
- `models/order/` - Order and cart data
- `repositories/` - Data access layer
- `services/` - API communication

**Benefits:**

- ✅ Type-safe data handling
- ✅ Easy to serialize/deserialize JSON
- ✅ Clear data contracts
- ✅ Facilitates testing

---

#### **3. `features/` - Feature Modules (UI Layer)**

**Purpose:** Feature-first organization where each feature is self-contained

**Current Features Implemented:**

##### **🏠 `home/` - Home Screen** ✅ Complete

- Restaurant listings with ratings and delivery times
- Category filters (Pizza, Burgers, Desserts, Sushi, Drinks)
- Daily deals promotional banner with gradient
- Search bar with filter functionality
- Trending dishes horizontal scroll

**Widgets:**

- `category_chip.dart` - Rounded category filter with icon
- `category_section.dart` - Horizontal scrollable list
- `daily_deals_banner.dart` - Gradient banner with CTA
- `home_search_bar.dart` - Search input with filter button
- `restaurant_card.dart` - Restaurant display with image, rating, time

##### **🍽️ `restaurant/` - Restaurant Details** ✅ Complete

- Large banner image with navigation controls
- Restaurant information (rating, delivery fee, timing)
- Menu categories (Popular, Appetizers, Main Courses, Desserts)
- Menu items with descriptions and add-to-cart buttons
- Sticky bottom cart bar

**Widgets:**

- `restaurant_banner.dart` - Hero image with back/favorite buttons
- `restaurant_info.dart` - Name, rating, delivery info
- `menu_category_tabs.dart` - Horizontal category tabs
- `menu_item_tile.dart` - Menu item with image and add button
- `view_cart_bar.dart` - Fixed bottom "Add to Cart" button

##### **🔍 `search/` - Search** ✅ Complete

- Search interface for restaurants and dishes
- Search bar with live input
- Empty state display

##### **📦 `orders/` - Orders** ✅ Complete

- Order history screen
- Order status display
- Empty state for no orders

##### **👤 `profile/` - User Profile** ✅ Complete

- User info header with avatar and edit button
- Menu sections: My Orders, Saved Addresses, Payment Methods, Settings
- Logout functionality

**Widgets:**

- `profile_header.dart` - Avatar with name and email
- `profile_menu_item.dart` - Navigable menu items with icons

##### **🎓 `onboarding/` - Onboarding** ✅ Complete

- Welcome slides for first-time users
- Introduction to app features

##### **🔐 `auth/` - Authentication** 🔄 In Progress

- Signup screen implemented
- Login and password reset pending

##### **🛒 `cart/` - Shopping Cart** 🔄 To Be Implemented

- Add/remove items
- Quantity adjustment
- Price calculation
- Coupon codes

##### **📍 `order_tracking/` - Live Tracking** 🔄 To Be Implemented

- Real-time order tracking
- Map integration
- Delivery partner info

**Benefits:**

- ✅ Feature isolation - Independent modules
- ✅ Scalability - Easy to add new features
- ✅ Team collaboration - Multiple developers can work simultaneously
- ✅ Maintainability - Clear code organization
- ✅ Reusability - Feature-specific widgets

---

#### **4. `navigation/` - Navigation Management**

**Purpose:** Handles app-wide navigation and routing

- **`bottom_nav_bar.dart`** - Bottom navigation component
  - 4 tabs: Home, Search, Orders, Profile
  - Active tab highlighting with orange accent
  - Icon and label display
- **`main_navigation.dart`** - Screen switching controller
  - Manages PageView for smooth transitions
  - Coordinates with bottom navigation
  - Prevents page swipe (controlled navigation only)

**Benefits:**

- ✅ Centralized navigation logic
- ✅ Smooth page transitions
- ✅ Consistent navigation experience
- ✅ Easy to extend with new tabs

---

#### **5. `services/` - API Services Layer**

**Purpose:** Will contain API communication logic

**Planned Structure:**

```
services/
├── auth_service.dart          # Login, signup, logout
├── restaurant_service.dart    # Fetch restaurants, menus
├── order_service.dart         # Place orders, track status
├── payment_service.dart       # Payment processing
└── notification_service.dart  # Push notifications
```

**Benefits:**

- ✅ Separation of concerns
- ✅ Easy to mock for testing
- ✅ Centralized API logic
- ✅ Error handling in one place

---

#### **6. `assets/` - Static Resources**

Images, fonts, and other static files organized by type.

---

## 11. 🛠️ Technologies Used

- **Framework:** Flutter (Dart)
- **State Management:** Provider / Riverpod
- **HTTP Client:** Dio
- **Local Storage:** SharedPreferences, Flutter Secure Storage
- **Navigation:** GoRouter
- **UI Components:** Material 3 with custom theming
- **Fonts:** Poppins, Inter (Google Fonts)

---

## 12. Screenshots of App Screens
1) Onboarding Screen
<img width="251" height="453" alt="Image" src="https://github.com/user-attachments/assets/d8d8b297-a13d-4d5f-8ccf-e53d6e6df892" />
<img width="206" height="440" alt="Image" src="https://github.com/user-attachments/assets/31cef42a-5f29-4802-aa21-0a9fbd5a307c" />
<img width="205" height="441" alt="Image" src="https://github.com/user-attachments/assets/ca7fabc7-058c-4240-99d7-2cd71cb062f9" />
<img width="204" height="443" alt="Image" src="https://github.com/user-attachments/assets/565ddd1d-12f1-49d9-b704-9aa8533588a5" />

---

2) Login Screen
<img width="192" height="341" alt="Image" src="https://github.com/user-attachments/assets/a70eb4ea-95ff-4720-a52e-54b79e21caf6" />
<img width="202" height="336" alt="Image" src="https://github.com/user-attachments/assets/2fd707b7-d20a-4294-984f-4985e34c1fa7" />

---

3) Signup Screen 
<img width="205" height="329" alt="Image" src="https://github.com/user-attachments/assets/7bcf25e0-9370-4b9d-864c-481986865b6c" />

---

4) Home Screen/ Program Listing 
<img width="242" height="430" alt="Image" src="https://github.com/user-attachments/assets/4cf0ff7e-50bf-4580-9cf4-3aa1da2e36f8" />

---

5) Program Details
<img width="226" height="424" alt="Image" src="https://github.com/user-attachments/assets/80d1a872-ce3c-488d-92e5-dde582eeaa4d" />
<img width="225" height="425" alt="Image" src="https://github.com/user-attachments/assets/accaaa7a-7037-47bf-9c71-e3f909cf622e" />
<img width="229" height="385" alt="Image" src="https://github.com/user-attachments/assets/524f47f4-eec2-4979-b2cf-f7d3f2b21f74" />
<img width="224" height="383" alt="Image" src="https://github.com/user-attachments/assets/95ea9405-cffd-4e22-9038-af1a2926eebf" />
<img width="253" height="402" alt="Image" src="https://github.com/user-attachments/assets/574841d5-93a2-4529-b2d9-e6b5216bcebc" />
<img width="251" height="401" alt="Image" src="https://github.com/user-attachments/assets/07bf5822-c9ad-4872-90d5-0213a5c199d8" />
<img width="258" height="413" alt="Image" src="https://github.com/user-attachments/assets/3e0a9754-99fd-42c9-bed5-af86bcd9838f" />
<img width="253" height="415" alt="Image" src="https://github.com/user-attachments/assets/888a96bb-b042-4bee-bdc9-60642188e440" />

---

6) Profile
<img width="282" height="441" alt="Image" src="https://github.com/user-attachments/assets/a4957a11-1b53-4665-856a-38e5570377a2" />

---

🚀 Getting Started
Prerequisites
Before you begin, ensure you have the following installed:

Flutter SDK (3.24.0 or higher)

bash flutter --version

Dart SDK (3.5.0 or higher)
Android Studio / VS Code with Flutter extensions
Xcode (for iOS development, macOS only)
Git for version control

Installation Steps

1. Clone the Repository
   bashgit clone https://github.com/mahrukhkamalcs/Foodify-.git
   cd Foodify-
2. Install Dependencies
   bashflutter pub get

```

#### 3. **Download Fonts**
Download and place the following fonts in `assets/fonts/`:

- **Poppins** - [Download from Google Fonts](https://fonts.google.com/specimen/Poppins)
  - Poppins-Regular.ttf (400)
  - Poppins-Medium.ttf (500)
  - Poppins-SemiBold.ttf (600)
  - Poppins-Bold.ttf (700)

- **Inter** - [Download from Google Fonts](https://fonts.google.com/specimen/Inter)
  - Inter-Regular.ttf (400)
  - Inter-Medium.ttf (500)
  - Inter-Bold.ttf (700)

**Font Directory Structure:**
```

assets/
└── fonts/
├── Poppins/
│ ├── Poppins-Regular.ttf
│ ├── Poppins-Medium.ttf
│ ├── Poppins-SemiBold.ttf
│ └── Poppins-Bold.ttf
└── Inter/
├── Inter-Regular.ttf
├── Inter-Medium.ttf
└── Inter-Bold.ttf 4. Check Flutter Setup
bashflutter doctor
Fix any issues reported by the doctor command. 5. Run the App
For Android:
bashflutter run
For iOS:
bashflutter run -d ios
For a specific device:
bash# List available devices
flutter devices

# Run on specific device

flutter run -d <device_id>

## 12. 🧠 Summary

FoodiFy aims to simplify food ordering by bringing together multiple vendors on one digital platform.  
It focuses on providing a smooth and responsive mobile experience for both customers and admins — ensuring convenience, efficiency, and engagement in food delivery operations.

**Current Status:** ✅ UI Implementation ongoing

---

🤝 Contributing
We welcome contributions! Please fork the repository and create a pull request with your changes.
