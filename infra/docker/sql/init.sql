-- Methy platform database initialization
-- This script runs when the SQL Server container starts for the first time.
-- Tables will be created by Entity Framework Core migrations in later phases.

CREATE DATABASE methy;
GO

-- Future tables (Phase 2+):
-- Users, Addresses, RefreshTokens (User Service)
-- Restaurants, MenuItems, Categories (Restaurant Service)
-- Orders, OrderItems, Carts (Order Service)
-- Payments, Transactions (Payment Service)
-- Notifications, NotificationTemplates (Notification Service)
-- Deliveries, DriverLocations (Delivery Service)
