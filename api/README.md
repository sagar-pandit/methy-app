# API Contracts

This directory contains OpenAPI 3.0 specifications for all Methy platform microservices.

## Files

| File | Service | Port |
|------|---------|------|
| `gateway.openapi.yml` | API Gateway | 5000 |
| `user-service.openapi.yml` | User Service | 5001 |
| `restaurant-service.openapi.yml` | Restaurant Service | 5002 |
| `order-service.openapi.yml` | Order Service | 5003 |
| `payment-service.openapi.yml` | Payment Service | 5004 |
| `notification-service.openapi.yml` | Notification Service | 5005 |
| `delivery-service.openapi.yml` | Delivery Service | 5006 |

## Current Status

All specs contain only a `/health` endpoint (scaffolding phase). Domain-specific endpoints will be added during Phase 2+.

## Validation

Use any OpenAPI linter (e.g., Spectral) to validate:

```bash
npx @stoplight/spectral-cli lint api/*.openapi.yml
```
