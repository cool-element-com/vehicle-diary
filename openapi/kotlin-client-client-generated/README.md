# io.swagger.client - Kotlin client library for Vehicle Diary OpenAPI 3.0

## Requires

* Kotlin 1.4.30
* Gradle 5.3

## Build

First, create the gradle wrapper script:

```
gradle wrapper
```

Then, run:

```
./gradlew check assemble
```

This runs all tests and packages the library.

## Features/Implementation Notes

* Supports JSON inputs/outputs, File inputs, and Form inputs.
* Supports collection formats for query parameters: csv, tsv, ssv, pipes.
* Some Kotlin and Java types are fully qualified to avoid conflicts with types defined in Swagger definitions.
* Implementation of ApiClient is intended to reduce method counts, specifically to benefit Android targets.

<a name="documentation-for-api-endpoints"></a>
## Documentation for API Endpoints

All URIs are relative to */*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*DefaultApi* | [**vehicleDiaryAppPost**](docs/DefaultApi.md#vehiclediaryapppost) | **POST** /vehicleDiary/app | Checkout web version of the app

<a name="documentation-for-models"></a>
## Documentation for Models

 - [io.swagger.client.models.VEvent](docs/VEvent.md)
 - [io.swagger.client.models.Vehicle](docs/Vehicle.md)

<a name="documentation-for-authorization"></a>
## Documentation for Authorization

All endpoints do not require authorization.
