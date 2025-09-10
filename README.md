# README


## Setup Instructions

### Prerequisites
- Ruby version 3.2.2
- PostgreSQL
- Node.js (version 16.0.0)
- Yarn (version 1.22.22)

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/MuhammadAhsan252/pet_adoption_platform.git
   cd pet_adoption_platform
   ```

2. Install dependencies:
   ```sh
   bundle install
   yarn install
   ```

### Database Setup
1. Create and setup the database:
   ```sh
   rails db:create
   rails db:migrate
   ```

### Running the Application
1. Start the Rails server:
   ```sh
   rails server
   ```

2. Open your browser and navigate to `http://localhost:3000`
