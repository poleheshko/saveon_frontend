# SaveOn Backend API Documentation

## Base URL
```
http://localhost:3000
```

## Authentication

Most endpoints require JWT authentication. Include the token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

---

## Table of Contents

1. [Authentication](#authentication-endpoints)
2. [Users](#users-endpoints)
3. [Accounts](#accounts-endpoints)
4. [Transactions](#transactions-endpoints)
5. [Categories](#categories-endpoints)
6. [Folders](#folders-endpoints)
7. [Statistics](#statistics-endpoints)

---

## Authentication Endpoints

### POST /auth/login

Login and receive JWT token.

**Authentication:** Not required

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200 OK):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "userId": 1,
    "email": "user@example.com",
    "name": "John",
    "surname": "Doe",
    "phoneNumber": "+1234567890",
    "birthday": "1990-01-01T00:00:00.000Z",
    "profileImagePath": "lib/assets/header_profile/profile_image.svg"
  }
}
```

**Error Response (401 Unauthorized):**
```json
{
  "statusCode": 401,
  "message": "Invalid email or password"
}
```

---

### GET /auth/profile

Get current user profile from JWT token.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200 OK):**
```json
{
  "userId": 1,
  "email": "user@example.com",
  "name": "John",
  "surname": "Doe",
  "phoneNumber": "+1234567890",
  "birthday": "1990-01-01T00:00:00.000Z",
  "profileImagePath": "lib/assets/header_profile/profile_image.svg"
}
```

---

## Users Endpoints

### POST /users

Create a new user account.

**Authentication:** Not required

**Request Body:**
```json
{
  "email": "newuser@example.com",
  "password": "password123",
  "name": "Jane",
  "surname": "Smith",
  "profileImagePath": "lib/assets/header_profile/custom_image.svg",
  "birthday": "1995-05-15",
  "phoneNumber": "+1234567890"
}
```

**Note:** `profileImagePath`, `birthday`, and `phoneNumber` are optional.

**Response (201 Created):**
```json
{
  "userId": 2,
  "email": "newuser@example.com",
  "name": "Jane",
  "surname": "Smith",
  "phoneNumber": "+1234567890",
  "birthday": "1995-05-15T00:00:00.000Z",
  "profileImagePath": "lib/assets/header_profile/custom_image.svg"
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": ["email must be an email", "password must be longer than or equal to 8 characters"],
  "error": "Bad Request"
}
```

---

### GET /users

Get current user profile.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200 OK):**
```json
{
  "userId": 1,
  "email": "user@example.com",
  "name": "John",
  "surname": "Doe",
  "phoneNumber": "+1234567890",
  "birthday": "1990-01-01T00:00:00.000Z",
  "profileImagePath": "lib/assets/header_profile/profile_image.svg"
}
```

---

## Accounts Endpoints

### POST /accounts

Create a new account.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "name": "Savings Account"
}
```

**Response (201 Created):**
```json
{
  "accountId": 1,
  "accountName": "Savings Account",
  "accountType": "PERSONAL",
  "createdAt": "2024-01-15T10:30:00.000Z"
}
```

---

### GET /accounts

Get all accounts for the authenticated user.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200 OK):**
```json
[
  {
    "accountId": 1,
    "accountName": "My Account",
    "accountType": "PERSONAL",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "role": "owner",
    "shareBps": 10000,
    "userAccountId": 1
  },
  {
    "accountId": 2,
    "accountName": "Savings Account",
    "accountType": "PERSONAL",
    "createdAt": "2024-01-16T14:20:00.000Z",
    "role": "owner",
    "shareBps": 10000,
    "userAccountId": 2
  }
]
```

---

### GET /accounts/:accountId

Get a specific account by ID.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `accountId` (number): The ID of the account

**Response (200 OK):**
```json
{
  "accountId": 1,
  "accountName": "My Account",
  "accountType": "PERSONAL",
  "createdAt": "2024-01-15T10:30:00.000Z",
  "users": [
    {
      "role": "owner",
      "shareBps": 10000,
      "user": {
        "userId": 1,
        "email": "user@example.com"
      }
    }
  ]
}
```

**Error Response (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Account not found"
}
```

---

## Transactions Endpoints

### POST /transactions

Create a new transaction.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "accountId": 1,
  "type": "EXPENSE",
  "amount": 50.99,
  "title": "Grocery Shopping",
  "categoryId": 1,
  "folderId": 1,
  "date": "2024-01-15T10:30:00.000Z"
}
```

**Note:**
- `type` must be either `"INCOME"` or `"EXPENSE"`
- `categoryId` is preferred (user-specific category ID). Required if `category` is not provided.
- `category` (string) is deprecated but kept for backward compatibility. Use `categoryId` instead.
- `folderId` and `date` are optional. If `date` is not provided, current date/time is used.

**Response (201 Created):**
```json
{
  "transactionId": 1,
  "accountId": 1,
  "type": "EXPENSE",
  "amount": 50.99,
  "title": "Grocery Shopping",
  "date": "2024-01-15T10:30:00.000Z",
  "createdAt": "2024-01-15T10:30:00.000Z",
  "categoryId": 1,
  "folderId": 1,
  "category": {
    "userCategoryId": 1,
    "userId": 1,
    "categoryName": "Groceries",
    "categoryIconPath": "lib/assets/category_icons/category_groceries.svg",
    "labelColor": "#CEF7CF",
    "textColor": "#2EB433",
    "isSystem": true,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  },
  "folder": {
    "folderId": 1,
    "userId": 1,
    "folderName": "Your first Folder",
    "folderIconPath": null,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  }
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": "Either categoryId or category must be provided. Prefer using categoryId."
}
```

**Error Response (403 Forbidden):**
```json
{
  "statusCode": 403,
  "message": "You do not have access to this account"
}
```

---

### GET /transactions

Get all transactions with optional filters.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Query Parameters:**
- `accountId` (number, optional): Filter by account ID
- `type` (string, optional): Filter by transaction type (`"INCOME"` or `"EXPENSE"`)
- `categoryId` (number, optional): Filter by category ID
- `folderId` (number, optional): Filter by folder ID
- `from` (string, optional): Filter transactions from this date (ISO 8601 format)
- `to` (string, optional): Filter transactions to this date (ISO 8601 format)

**Example Request:**
```
GET /transactions?accountId=1&type=EXPENSE&from=2024-01-01&to=2024-01-31
```

**Response (200 OK):**
```json
[
  {
    "transactionId": 1,
    "accountId": 1,
    "type": "EXPENSE",
    "amount": 50.99,
    "title": "Grocery Shopping",
    "date": "2024-01-15T10:30:00.000Z",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "categoryId": 1,
    "folderId": 1,
    "category": {
      "userCategoryId": 1,
      "userId": 1,
      "categoryName": "Groceries",
      "categoryIconPath": "lib/assets/category_icons/category_groceries.svg",
      "labelColor": "#CEF7CF",
      "textColor": "#2EB433",
      "isSystem": true,
      "createdAt": "2024-01-15T10:00:00.000Z",
      "updatedAt": "2024-01-15T10:00:00.000Z"
    },
    "folder": {
      "folderId": 1,
      "userId": 1,
      "folderName": "Your first Folder",
      "folderIconPath": null,
      "createdAt": "2024-01-15T10:00:00.000Z",
      "updatedAt": "2024-01-15T10:00:00.000Z"
    }
  }
]
```

---

### PATCH /transactions/:id

Update a transaction.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the transaction to update

**Request Body:**
```json
{
  "title": "Updated Title",
  "amount": 75.50,
  "categoryId": 2,
  "folderId": 2,
  "date": "2024-01-20T12:00:00.000Z"
}
```

**Note:** All fields in the request body are optional. Only provided fields will be updated.

**Response (200 OK):**
```json
{
  "transactionId": 1,
  "accountId": 1,
  "type": "EXPENSE",
  "amount": 75.50,
  "title": "Updated Title",
  "date": "2024-01-20T12:00:00.000Z",
  "createdAt": "2024-01-15T10:30:00.000Z",
  "categoryId": 2,
  "folderId": 2,
  "category": {
    "userCategoryId": 2,
    "userId": 1,
    "categoryName": "Restaurants",
    "categoryIconPath": "lib/assets/category_icons/category_restaurants.svg",
    "labelColor": "#FFDAE9",
    "textColor": "#E1075E",
    "isSystem": true,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  },
  "folder": {
    "folderId": 2,
    "userId": 1,
    "folderName": "Vacation",
    "folderIconPath": null,
    "createdAt": "2024-01-16T10:00:00.000Z",
    "updatedAt": "2024-01-16T10:00:00.000Z"
  }
}
```

**Error Response (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Transaction not found"
}
```

---

### DELETE /transactions/:id

Delete a transaction.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the transaction to delete

**Response (200 OK):**
```json
{
  "transactionId": 1,
  "accountId": 1,
  "type": "EXPENSE",
  "amount": 50.99,
  "title": "Grocery Shopping",
  "date": "2024-01-15T10:30:00.000Z",
  "createdAt": "2024-01-15T10:30:00.000Z",
  "categoryId": 1,
  "folderId": 1
}
```

**Error Response (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Transaction not found"
}
```

---

## Categories Endpoints

### GET /categories

Get all categories for the authenticated user.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200 OK):**
```json
[
  {
    "userCategoryId": 1,
    "userId": 1,
    "categoryName": "Groceries",
    "categoryIconPath": "lib/assets/category_icons/category_groceries.svg",
    "labelColor": "#CEF7CF",
    "textColor": "#2EB433",
    "isSystem": true,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  },
  {
    "userCategoryId": 2,
    "userId": 1,
    "categoryName": "Restaurants",
    "categoryIconPath": "lib/assets/category_icons/category_restaurants.svg",
    "labelColor": "#FFDAE9",
    "textColor": "#E1075E",
    "isSystem": true,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  },
  {
    "userCategoryId": 12,
    "userId": 1,
    "categoryName": "Custom Category",
    "categoryIconPath": "lib/assets/category_icons/custom.svg",
    "labelColor": "#FF0000",
    "textColor": "#FFFFFF",
    "isSystem": false,
    "createdAt": "2024-01-20T10:00:00.000Z",
    "updatedAt": "2024-01-20T10:00:00.000Z"
  }
]
```

---

### GET /categories/:id

Get a specific category by ID.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the category

**Response (200 OK):**
```json
{
  "userCategoryId": 1,
  "userId": 1,
  "categoryName": "Groceries",
  "categoryIconPath": "lib/assets/category_icons/category_groceries.svg",
  "labelColor": "#CEF7CF",
  "textColor": "#2EB433",
  "isSystem": true,
  "createdAt": "2024-01-15T10:00:00.000Z",
  "updatedAt": "2024-01-15T10:00:00.000Z"
}
```

**Error Response (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Category with ID 1 not found"
}
```

---

### POST /categories

Create a new custom category.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "categoryName": "Custom Category",
  "categoryIconPath": "lib/assets/category_icons/custom.svg",
  "labelColor": "#FF0000",
  "textColor": "#FFFFFF"
}
```

**Note:** `categoryIconPath`, `labelColor`, and `textColor` are optional.

**Response (201 Created):**
```json
{
  "userCategoryId": 12,
  "userId": 1,
  "categoryName": "Custom Category",
  "categoryIconPath": "lib/assets/category_icons/custom.svg",
  "labelColor": "#FF0000",
  "textColor": "#FFFFFF",
  "isSystem": false,
  "createdAt": "2024-01-20T10:00:00.000Z",
  "updatedAt": "2024-01-20T10:00:00.000Z"
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": "Category \"Custom Category\" already exists"
}
```

---

### PATCH /categories/:id

Update a category.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the category to update

**Request Body:**
```json
{
  "categoryName": "Updated Category Name",
  "categoryIconPath": "lib/assets/category_icons/updated.svg",
  "labelColor": "#00FF00",
  "textColor": "#000000"
}
```

**Note:** 
- All fields are optional
- System categories cannot be renamed (only icon and colors can be updated)
- Custom categories can be fully updated

**Response (200 OK):**
```json
{
  "userCategoryId": 12,
  "userId": 1,
  "categoryName": "Updated Category Name",
  "categoryIconPath": "lib/assets/category_icons/updated.svg",
  "labelColor": "#00FF00",
  "textColor": "#000000",
  "isSystem": false,
  "createdAt": "2024-01-20T10:00:00.000Z",
  "updatedAt": "2024-01-20T11:00:00.000Z"
}
```

**Error Response (403 Forbidden):**
```json
{
  "statusCode": 403,
  "message": "Cannot rename system categories"
}
```

---

### DELETE /categories/:id

Delete a category.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the category to delete

**Response (200 OK):**
```json
{
  "userCategoryId": 12,
  "userId": 1,
  "categoryName": "Custom Category",
  "categoryIconPath": "lib/assets/category_icons/custom.svg",
  "labelColor": "#FF0000",
  "textColor": "#FFFFFF",
  "isSystem": false,
  "createdAt": "2024-01-20T10:00:00.000Z",
  "updatedAt": "2024-01-20T10:00:00.000Z"
}
```

**Error Response (403 Forbidden):**
```json
{
  "statusCode": 403,
  "message": "Cannot delete system categories"
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": "Cannot delete category \"Custom Category\" because it is used in 5 transaction(s)"
}
```

---

## Folders Endpoints

### GET /folders

Get all folders for the authenticated user.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200 OK):**
```json
[
  {
    "folderId": 1,
    "userId": 1,
    "folderName": "Your first Folder",
    "folderIconPath": null,
    "createdAt": "2024-01-15T10:00:00.000Z",
    "updatedAt": "2024-01-15T10:00:00.000Z"
  },
  {
    "folderId": 2,
    "userId": 1,
    "folderName": "Vacation",
    "folderIconPath": "lib/assets/folder_icons/vacation.svg",
    "createdAt": "2024-01-16T10:00:00.000Z",
    "updatedAt": "2024-01-16T10:00:00.000Z"
  }
]
```

---

### GET /folders/:id

Get a specific folder by ID.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the folder

**Response (200 OK):**
```json
{
  "folderId": 1,
  "userId": 1,
  "folderName": "Your first Folder",
  "folderIconPath": null,
  "createdAt": "2024-01-15T10:00:00.000Z",
  "updatedAt": "2024-01-15T10:00:00.000Z"
}
```

**Error Response (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Folder with ID 1 not found"
}
```

---

### POST /folders

Create a new folder.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "folderName": "Vacation",
  "folderIconPath": "lib/assets/folder_icons/vacation.svg"
}
```

**Note:** `folderIconPath` is optional.

**Response (201 Created):**
```json
{
  "folderId": 2,
  "userId": 1,
  "folderName": "Vacation",
  "folderIconPath": "lib/assets/folder_icons/vacation.svg",
  "createdAt": "2024-01-16T10:00:00.000Z",
  "updatedAt": "2024-01-16T10:00:00.000Z"
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": "Folder \"Vacation\" already exists"
}
```

---

### PATCH /folders/:id

Update a folder.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the folder to update

**Request Body:**
```json
{
  "folderName": "Updated Folder Name",
  "folderIconPath": "lib/assets/folder_icons/updated.svg"
}
```

**Note:** All fields are optional. Only provided fields will be updated.

**Response (200 OK):**
```json
{
  "folderId": 2,
  "userId": 1,
  "folderName": "Updated Folder Name",
  "folderIconPath": "lib/assets/folder_icons/updated.svg",
  "createdAt": "2024-01-16T10:00:00.000Z",
  "updatedAt": "2024-01-16T11:00:00.000Z"
}
```

---

### DELETE /folders/:id

Delete a folder.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**URL Parameters:**
- `id` (number): The ID of the folder to delete

**Response (200 OK):**
```json
{
  "folderId": 2,
  "userId": 1,
  "folderName": "Vacation",
  "folderIconPath": "lib/assets/folder_icons/vacation.svg",
  "createdAt": "2024-01-16T10:00:00.000Z",
  "updatedAt": "2024-01-16T10:00:00.000Z"
}
```

**Error Response (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": "Cannot delete folder \"Vacation\" because it is used in 3 transaction(s)"
}
```

---

## Statistics Endpoints

### GET /transactions/stats/summary

Get financial summary (total income, total expense, balance).

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Query Parameters:**
- `accountId` (number, optional): Filter by account ID
- `from` (string, optional): Filter transactions from this date (ISO 8601 format)
- `to` (string, optional): Filter transactions to this date (ISO 8601 format)

**Example Request:**
```
GET /transactions/stats/summary?accountId=1&from=2024-01-01&to=2024-01-31
```

**Response (200 OK):**
```json
{
  "totalIncome": 5000.00,
  "totalExpense": 3200.50,
  "balance": 1799.50
}
```

---

### GET /transactions/stats/categories

Get expense statistics grouped by category.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Query Parameters:**
- `accountId` (number, optional): Filter by account ID
- `from` (string, optional): Filter transactions from this date (ISO 8601 format)
- `to` (string, optional): Filter transactions to this date (ISO 8601 format)

**Example Request:**
```
GET /transactions/stats/categories?accountId=1&from=2024-01-01&to=2024-01-31
```

**Response (200 OK):**
```json
[
  {
    "categoryId": 1,
    "categoryName": "Groceries",
    "categoryIconPath": "lib/assets/category_icons/category_groceries.svg",
    "labelColor": "#CEF7CF",
    "textColor": "#2EB433",
    "totalExpense": 850.50
  },
  {
    "categoryId": 2,
    "categoryName": "Restaurants",
    "categoryIconPath": "lib/assets/category_icons/category_restaurants.svg",
    "labelColor": "#FFDAE9",
    "textColor": "#E1075E",
    "totalExpense": 450.00
  },
  {
    "categoryId": 3,
    "categoryName": "Transport",
    "categoryIconPath": "lib/assets/category_icons/category_transport.svg",
    "labelColor": "#1E64FA",
    "textColor": "#1E64FA",
    "totalExpense": 200.00
  }
]
```

---

### GET /transactions/stats/timeline

Get income and expense statistics grouped by time period.

**Authentication:** Required (JWT)

**Request Headers:**
```
Authorization: Bearer <jwt_token>
```

**Query Parameters:**
- `accountId` (number, optional): Filter by account ID
- `from` (string, optional): Filter transactions from this date (ISO 8601 format)
- `to` (string, optional): Filter transactions to this date (ISO 8601 format)
- `period` (string, optional): Grouping period - `"day"`, `"week"`, or `"month"` (default: `"day"`)

**Example Request:**
```
GET /transactions/stats/timeline?accountId=1&from=2024-01-01&to=2024-01-31&period=week
```

**Response (200 OK):**
```json
[
  {
    "period": "2024-01",
    "income": 5000.00,
    "expense": 3200.50
  },
  {
    "period": "2024-02",
    "income": 4500.00,
    "expense": 2800.00
  }
]
```

**Example Response (day period):**
```json
[
  {
    "period": "2024-01-15",
    "income": 500.00,
    "expense": 150.50
  },
  {
    "period": "2024-01-16",
    "income": 0,
    "expense": 200.00
  }
]
```

**Example Response (week period):**
```json
[
  {
    "period": "2024-W03",
    "income": 1500.00,
    "expense": 800.50
  },
  {
    "period": "2024-W04",
    "income": 1200.00,
    "expense": 600.00
  }
]
```

---

## Error Responses

All endpoints may return the following error responses:

### 400 Bad Request
```json
{
  "statusCode": 400,
  "message": "Error message describing what went wrong",
  "error": "Bad Request"
}
```

### 401 Unauthorized
```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### 403 Forbidden
```json
{
  "statusCode": 403,
  "message": "Access denied"
}
```

### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Resource not found"
}
```

---

## Notes

1. **JWT Token**: After logging in, include the `accessToken` in the `Authorization` header for all protected endpoints:
   ```
   Authorization: Bearer <accessToken>
   ```

2. **Date Formats**: All dates should be in ISO 8601 format (e.g., `"2024-01-15T10:30:00.000Z"`).

3. **Transaction Types**: 
   - `"INCOME"` - Money coming in
   - `"EXPENSE"` - Money going out

4. **Account Types**:
   - `"PERSONAL"` - Personal account (default)
   - `"SAVINGS"` - Savings account
   - `"EXPENSES"` - Expenses account
   - `"JOINT"` - Joint account

5. **System Categories**: Default categories are created automatically for each user and cannot be deleted or renamed (only icon and colors can be updated).

6. **Validation**: All request bodies are validated. Invalid requests will return a 400 Bad Request with details about validation errors.

