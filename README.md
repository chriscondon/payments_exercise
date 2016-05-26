OpenFEC API allows you to explore the way candidates and committees fund their campaigns.

The API is a RESTful web service supporting full-text and field-specific searches on FEC data.This API allows you to explore the vast array of campaign finance data that the FEC collects. Each endpoint focuses on a different aspect of disclosure. Information is tied to the underlying forms by file ID and image ID.

Base URI:     https://localhost:3000/

HTTP Methods:    GET, POST

Response format: .json




## Installation

Clone repository to local environment.

````
git clone http://github.com/chriscondon/payments_exercise
```

Run bundle installer and migrations.

````
bundle install
rake db:migrate
```


## Testing

Testing implemented through RSpec.  To run all tests with documentation, use the command:

````
rspec -fd
```


## Endpoints

# Loans
````
/loans/
/loans/:id
/loans/:id/payments
```

# Payments

````
/payments/
/payments/:id
```



## Instructions

# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.
