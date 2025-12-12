
# Construction Hub

**Construction Hub** is a web-based platform designed to unify construction equipment sales and contractor-client project interactions in one central place. The system enables users to browse and order construction tools and equipment, while also allowing individuals to post construction project requests so that contractors can view and communicate offers directly.

This application aims to simplify procurement and contractor engagement by providing an accessible online marketplace that brings together equipment suppliers, buyers, and construction professionals.

---

## Features

### User Features

* **User Registration and Login:** Users can create an account, log in securely, and manage their profile information.
* **Browse Products:** Users can view available construction equipment and tools with details such as description, price, and quantity.
* **Shopping Cart and Orders:** Users can add multiple items to a cart and place orders efficiently through the platform.
* **Profile Management:** Users can update and manage their personal information.

### Project Posting

* **Construction Project Requests:** Users can submit construction project requests. Each project includes a title, description, budget, preferred timeline, and contact details.
* Contractors can review posted projects and choose to contact the client to negotiate and finalize a deal.
* This feature enables clients to find suitable contractors based on their specific construction requirements.

### Administrator Features

* **Product Management:** Administrators can add, edit, and delete products to maintain an up-to-date equipment catalog.
* **Order Management:** Administrators can view and update order status, including approval and rejection workflows.
* **User Oversight:** Administrators oversee user activities and manage user accounts if necessary.

---

## Technology Stack

The application is developed using:

* **Java Servlets and JSP** for the backend
* **MySQL** for database management
* **Swing** for the front-end interface
* **Tomcat** as the application server

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

   * Create a MySQL database (e.g., `construction_hub`)
   * Import the provided SQL schema if included, or create tables for:

     * Users
     * Products
     * Orders
     * ProjectPosts
   * Update database connection settings in the project configuration.

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

Let me know if you would like this converted to another format, such as PDF, or if you want additional sections like **ER Diagram**, **Use Case Models**, or **API Documentation**.
