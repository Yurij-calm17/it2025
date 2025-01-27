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

CREATE TABLE Assigned (
    personnel_id INT,
    vehicle_id INT,
    PRIMARY KEY (personnel_id, vehicle_id),
    FOREIGN KEY (personnel_id) REFERENCES Personnel(id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id) ON DELETE CASCADE
);
-- Вставка даних у таблицю Routes
INSERT INTO Routes (id, name, start_point, end_point, distance_km, average_time_hr) VALUES
(1, 'Route A', 'Kyiv', 'Lviv', 540.50, 6.5),
(2, 'Route B', 'Lviv', 'Odessa', 750.80, 9.2),
(3, 'Route C', 'Odessa', 'Dnipro', 490.30, 5.8),
(4, 'Route D', 'Dnipro', 'Kharkiv', 220.40, 3.2),
(5, 'Route E', 'Kharkiv', 'Kyiv', 470.00, 6.1);

-- Вставка даних у таблицю Vehicles
INSERT INTO Vehicles (id, type, model, load_capacity_ton, speed_kmh) VALUES
(1, 'Truck', 'Volvo FH', 20.0, 90.0),
(2, 'Van', 'Mercedes Sprinter', 3.5, 110.0),
(3, 'Truck', 'Scania R500', 18.0, 85.0),
(4, 'Truck', 'MAN TGX', 22.0, 88.0),
(5, 'Van', 'Ford Transit', 3.2, 105.0);

-- Вставка даних у таблицю Personnel
DELETE FROM Personnel;
INSERT INTO Personnel (id, name, position, experience_years) VALUES
(1, 'Ivan Petrov', 'Driver', 10),
(2, 'Oleg Sidorov', 'Driver', 5),
(3, 'Anna Kovalenko', 'Dispatcher', 7),
(4, 'Serhiy Bondar', 'Mechanic', 12),
(5, 'Mykola Lysenko', 'Driver', 8);

-- Вставка даних у таблицю Serves
INSERT INTO Serves (vehicle_id, route_id) VALUES
(1, 2),
(2, 4),
(3, 1),
(4, 3),
(5, 5),
(3, 2),
(1, 3),
(5, 4)
ON CONFLICT (vehicle_id, route_id) DO NOTHING;

