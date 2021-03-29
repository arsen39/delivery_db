DROP TABLE "orders_to_deliveries";
DROP TABLE "orders";
DROP TABLE "products";
DROP TABLE "contracts";
DROP TABLE "deliveries";
DROP TABLE "persons";

CREATE TABLE "products" (
  id serial PRIMARY KEY,
  "name" varchar(255) UNIQUE NOT NULL,
  "price" decimal(15,2)
);

CREATE TABLE "persons" (
  id serial PRIMARY KEY,
  "firstName" varchar(64),
  "lastName" varchar(64),
  "adress" jsonb NOT NULL,
  "phoneNumber" varchar(13)
);

CREATE TABLE "contracts" (
  id serial PRIMARY KEY,
  "enteredIntoAt" timestamp NOT NULL DEFAULT current_timestamp,
  "customerId" int REFERENCES "persons"
);

CREATE TABLE "orders" (
  id serial PRIMARY KEY,
  "productId" int REFERENCES "products",
  "quantity" int NOT NULL CHECK ("quantity" > 0),
  "contractId" int REFERENCES "contracts"
);

CREATE TABLE "deliveries" (
  id serial PRIMARY KEY,
  "deliveredAt" timestamp NOT NULL DEFAULT current_timestamp,
  "recipient" int REFERENCES "persons"
);

CREATE TABLE "orders_to_deliveries" (
  "deliveryId" int REFERENCES "deliveries",
  "orderId" int REFERENCES "orders",
  "actualQuantity" int NOT NULL CHECK ("actualQuantity" > 0),
  PRIMARY KEY ("deliveryId", "orderId")
);