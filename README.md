# RailTrack Pro

**RailTrack Pro** is a comprehensive train reservation system that supports customers, administrators, and customer representatives through an integrated platform. The system offers robust account management, advanced search and reservation features, interactive Q&A capabilities, and extensive reporting tools, ensuring seamless functionality and user experience.

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

## Features

### Account Management
- Customer registration and secure login for all user types.
- Logout functionality to ensure session security.

### Customer Features
1. **Search and Browse**:
   - Search train schedules by origin, destination, and date of travel.
   - View comprehensive schedules with route, stop, and fare details.
   - Sort schedules by arrival time, departure time, and fare.

2. **Reservation System**:
   - Book round-trip and one-way journeys.
   - Special discounts for children, seniors, and disabled passengers.
   - Manage reservations with cancellation options.
   - View current and past reservations.

3. **Interactive Q&A**:
   - Submit questions to customer representatives.
   - Search FAQs using keywords.
   - Receive support through the question-answer system.

### Administrative Features
- Manage customer representatives (add/edit/delete).
- Generate detailed reports:
  - Monthly sales and revenue reports.
  - Reservation listings by transit line and customer name.
  - Identify the best customer and top 5 most active transit lines.

### Customer Representative Features
- Manage train schedules and update records.
- Handle customer queries via the interactive Q&A system.
- Access station-specific schedules and customer listings for specific transit lines and dates.

---

## Relationships
1. **Customer & Reservations**: One-to-Many  
2. **Customer Representative & Schedules**: Many-to-Many  
3. **Train & Schedules**: One-to-Many  
4. **Station & Schedule**: Many-to-Many  
5. **Station & Stops**: One-to-Many  
6. **Train Schedule & Reservations**: One-to-Many  
7. **Reservation & Fare Discount**: One-to-Many  
8. **Customer & FAQ**: Many-to-Many  
9. **Customer Representative & FAQ**: Many-to-Many  
10. **Admin & Revenue**: One-to-Many  
11. **Admin & Customer Representative**: One-to-Many  

---

## Tech Stack
- **Backend**: Java (Eclipse), Tomcat.
- **Frontend**: HTML, CSS (Bootstrap), JavaScript.
- **Database**: SQL.
- **Frameworks**: Java and JSP.

