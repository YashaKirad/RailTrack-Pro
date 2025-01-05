# RailTrack Pro

**RailTrack Pro** is a comprehensive train reservation system designed to streamline operations for customers, administrators, and customer representatives. The system offers advanced account management, browsing, and search features, robust reservation capabilities, and extensive administrative and reporting tools, ensuring an efficient and user-friendly experience.

---

## Features and Functionalities

### I. Account Management (10 points)
- Customer registration system.
- Login functionality for customers, administrators, and customer representatives.
- Secure logout for all user types.

### II. Browsing and Search Functionality (15 points)
- Advanced search for train schedules by:
  - Origin station.
  - Destination station.
  - Date of travel.
- Browsing resulting schedules with:
  - Detailed route information.
  - Stops and fare details.
- Sorting schedules by:
  - Arrival time.
  - Departure time.
  - Fare.

### III. Reservations (15 points)
- Reservation capabilities for specific routes:
  - Round-trip or one-way journeys.
- Special discounts for:
  - Children, seniors, and disabled passengers.
- Reservation management:
  - Cancel existing reservations.
  - View current and past reservations with detailed information.

### IV. Administrative Functions (30 points)
- Administrative account creation (predefined).
- Manage customer representatives:
  - Add, edit, and delete information.
- Generate detailed reports:
  - Monthly sales reports.
  - List of reservations by:
    - Transit line.
    - Customer name.
  - Revenue listings by:
    - Transit line.
    - Customer name.
- Identify key metrics:
  - Best customer.
  - Top 5 most active transit lines.

### V. Customer Representative Functions (30 points)
- Train schedule management:
  - Edit and delete train schedule information.
- Interactive Q&A system:
  - Browse customer questions and answers.
  - Search questions by keywords.
  - Allow customers to submit questions to customer service.
  - Respond to customer-submitted questions.
- Reporting tools:
  - List train schedules for a given station (as origin/destination).
  - Produce a list of all customers with reservations on a specific transit line and date.

---

## Relationships
1. **Customer & Reservations**: One-to-Many.  
2. **Customer Representative & Schedules**: Many-to-Many.  
3. **Train & Schedules**: One-to-Many.  
4. **Station & Schedule**: Many-to-Many.  
5. **Station & Stops**: One-to-Many.  
6. **Train Schedule & Reservations**: One-to-Many.  
7. **Reservation & Fare Discount**: One-to-Many.  
8. **Customer & FAQ**: Many-to-Many.  
9. **Customer Representative & FAQ**: Many-to-Many.  
10. **Admin & Revenue**: One-to-Many.  
11. **Admin & Customer Representative**: One-to-Many.  

---

## Tech Stack
- **Backend**: Java (Eclipse), Tomcat.
- **Frontend**: HTML, CSS (Bootstrap), JavaScript.
- **Database**: SQL.
- **Frameworks**: Java and JSP.

---

## Login Credentials
- **Customer Login**:
  - Username: `emilyjohnson2`
  - Password: `password456`
- **Customer Representative Login**:
  - Username: `chrisrep1`
  - Password: `password123`
- **Admin Login**:
  - Username: `admin1`
  - Password: `admin123`

---

## Description
RailTrack Pro is a feature-rich train reservation system that enables customers, administrators, and customer representatives to manage reservations, schedules, and queries seamlessly. Built with Java, SQL, and modern web technologies, it ensures secure account management, advanced search capabilities, and comprehensive reporting tools.

---

