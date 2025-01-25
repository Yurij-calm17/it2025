-- Active: 1737458445459@@127.0.0.1@5432@logisticroutesmanagment@public
CREATE DATABASE LogisticRoutesManagment;

CREATE TABLE Routes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    start_point VARCHAR(255) NOT NULL,
    end_point VARCHAR(255) NOT NULL,
    distance_km DECIMAL(10,2) NOT NULL,
    average_time_hr DECIMAL(5,2) NOT NULL
);

CREATE TABLE Vehicles (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    load_capacity_ton DECIMAL(10,2),
    speed_kmh DECIMAL(5,2)
);

CREATE TABLE Personnel (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    experience_years INT NOT NULL
);

CREATE TABLE Serves (
    vehicle_id INT,
    route_id INT,
    PRIMARY KEY (vehicle_id, route_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id) ON DELETE CASCADE,
    FOREIGN KEY (route_id) REFERENCES Routes(id) ON DELETE CASCADE
);

CREATE TABLE Operates (
    route_id INT,
    vehicle_id INT,
    departure_date DATE NOT NULL,
    arrival_date DATE NOT NULL,
    PRIMARY KEY (route_id, vehicle_id, departure_date),
    FOREIGN KEY (route_id) REFERENCES Routes(id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id) ON DELETE CASCADE
);

CREATE TABLE Assigned (
    personnel_id INT,
    vehicle_id INT,
    PRIMARY KEY (personnel_id, vehicle_id),
    FOREIGN KEY (personnel_id) REFERENCES Personnel(id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id) ON DELETE CASCADE
);