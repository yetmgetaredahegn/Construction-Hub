# Construction Hub – Contractors, Equipment and Clients In One Place

**Construction Hub** is a web-based platform designed to modernize how construction companies, contractors, clients, and equipment suppliers interact. It serves as an integrated marketplace where construction equipment can be bought or sold, and where clients can directly post construction projects for contractors to review. The system aims to replace the scattered, time-consuming methods of finding equipment or hiring contractors, offering a central, efficient, and digital environment.

The platform allows users to browse construction tools, heavy machines, and building materials while also enabling individuals or organizations to request full construction services. Contractors and suppliers can list equipment, manage their inventory, respond to project postings, and communicate with potential customers. Meanwhile, clients gain access to a streamlined method of sourcing both equipment and qualified contractors.

This project is unique because it is a **two-way connection center**. Both suppliers and clients can put what they want. Suppliers can get buyers by posting their products. Clients can get a construction company which meets their allotted budget and working locations. Contractors registered on the platform can view these requests, contact the client, negotiate terms, and finalize a deal. This feature transforms the system into a dual marketplace — not only for equipment but also for construction contracting services.

It allows clients to easily find builders without physically visiting companies, and helps contractors find new job opportunities directly from the platform.

---

## Main Features

1. **Project Posting for Construction Services**
   * Users can post construction projects they want completed by contractors
   * Each project posting includes: project description (e.g., house, shop, apartment, warehouse), budget, location (optional), and contact information
   * Contractors can view posted projects and contact clients directly

2. **User Account Management**
   * Users can register, log in, update profiles, manage communication details, and track activities
   * Each account includes profile details and history of orders or project postings

3. **Equipment Browsing and Catalog Viewing**
   * Well-organized catalog of construction equipment
   * Categories include: heavy machinery, electrical tools, cutting equipment, safety gear, and more
   * Each item includes detailed specifications, price, availability, and images

4. **Shopping Cart and Ordering System**
   * Users can add multiple items to a shopping cart and place orders easily
   * Allows contractors or construction teams to collect all required equipment in one transaction

5. **Administrative Management Interface**
   * Administrators can add equipment listings, update product details, remove unavailable items
   * Handle user orders and monitor user activities

6. **Order Tracking and Status Updates**
   * Track order status (pending, accepted, rejected, or completed)
   * Helps contractors plan schedules, delivery, and resource usage

7. **Secure Authentication and Session Management**
   * Only authorized users can interact with sensitive features
   * Secure login and session handling protect user data and transactions

---

## Technology Stack

The application is developed using:

* **Java Servlets and JSP** for the backend
* **MySQL** for database management
* **Bootstrap** for responsive web interface
* **Apache Tomcat** as the application server

---

## System Requirements

Before running the application, ensure you have the following installed:

* Java Development Kit (JDK) 8 or higher
* Apache Tomcat
* MySQL Server
* A suitable IDE (such as Eclipse or IntelliJ IDEA)

---

## Installation and Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yetmgetaredahegn/Construction-Hub.git
   ```

2. **Configure Database**

   * The application will automatically create the `construction_hub` database on first run
   * All required tables (users, products, orders, notifications, cart) will be created automatically
   * Ensure MySQL is running and update database credentials in `src/java/aos/dao/DatabaseProvider.java` if needed

3. **Deploy the Application**

   * Import the project into your Java IDE.
   * Configure the Apache Tomcat server.
   * Build and run the project on the server.

4. **Access the Platform**

   * Open a web browser and navigate to the local host URL provided by the Tomcat server (e.g., `http://localhost:8080/Construction-Hub`).

---

## Usage

### For General Users

1. Register for a new account.
2. Browse the product catalog.
3. Add products to your cart and place orders.
4. Submit construction project requests with detailed descriptions and budget.
5. Review contractors who reach out based on your project request.

### For Contractors

1. Log into your account.
2. View available construction projects posted by clients.
3. Contact clients to negotiate terms or submit proposals.

### For Administrators

1. Log into the administrator panel.
2. Add or update equipment listings.
3. Manage user orders and project listings.
4. Monitor platform activity to ensure integrity.

---

## Future Enhancements

Potential enhancements to maximize platform value include:

* Advanced search and filtering by equipment type and project requirements.
* Contractor rating and review system.
* Messaging system for in-platform communication.
* Rental management features for heavy equipment.

---

## Contributing

Contributions are welcome. If you would like to contribute, please fork the repository, make your changes, and submit a pull request with detailed information about your updates.

---

## License

This is final project for Advanced Programming course which is given under Adama Science and Technology University.

---
