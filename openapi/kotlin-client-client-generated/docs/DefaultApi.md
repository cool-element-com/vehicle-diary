# DefaultApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vehicleDiaryAppPost**](DefaultApi.md#vehicleDiaryAppPost) | **POST** /vehicleDiary/app | Checkout web version of the app

<a name="vehicleDiaryAppPost"></a>
# **vehicleDiaryAppPost**
> vehicleDiaryAppPost(body)

Checkout web version of the app

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val body : VEvent =  // VEvent | Checkout web version of the app
try {
    apiInstance.vehicleDiaryAppPost(body)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#vehicleDiaryAppPost")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#vehicleDiaryAppPost")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**VEvent**](VEvent.md)| Checkout web version of the app |

### Return type

null (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

