//
// Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSLogsResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSLogsResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSLogsResources

+ (instancetype)sharedInstance {
    static AWSLogsResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSLogsResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2014-03-28\",\
    \"endpointPrefix\":\"logs\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceFullName\":\"Amazon CloudWatch Logs\",\
    \"serviceId\":\"CloudWatch Logs\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"Logs_20140328\",\
    \"uid\":\"logs-2014-03-28\"\
  },\
  \"operations\":{\
    \"AssociateKmsKey\":{\
      \"name\":\"AssociateKmsKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssociateKmsKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Associates the specified AWS Key Management Service (AWS KMS) customer master key (CMK) with the specified log group.</p> <p>Associating an AWS KMS CMK with a log group overrides any existing associations between the log group and a CMK. After a CMK is associated with a log group, all newly ingested data for the log group is encrypted using the CMK. This association is stored as long as the data encrypted with the CMK is still within Amazon CloudWatch Logs. This enables Amazon CloudWatch Logs to decrypt this data whenever it is requested.</p> <p>Note that it can take up to 5 minutes for this operation to take effect.</p> <p>If you attempt to associate a CMK with a log group but the CMK does not exist or the CMK is disabled, you will receive an <code>InvalidParameterException</code> error. </p>\"\
    },\
    \"CancelExportTask\":{\
      \"name\":\"CancelExportTask\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CancelExportTaskRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidOperationException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Cancels the specified export task.</p> <p>The task must be in the <code>PENDING</code> or <code>RUNNING</code> state.</p>\"\
    },\
    \"CreateExportTask\":{\
      \"name\":\"CreateExportTask\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateExportTaskRequest\"},\
      \"output\":{\"shape\":\"CreateExportTaskResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceAlreadyExistsException\"}\
      ],\
      \"documentation\":\"<p>Creates an export task, which allows you to efficiently export data from a log group to an Amazon S3 bucket.</p> <p>This is an asynchronous call. If all the required information is provided, this operation initiates an export task and responds with the ID of the task. After the task has started, you can use <a>DescribeExportTasks</a> to get the status of the export task. Each account can only have one active (<code>RUNNING</code> or <code>PENDING</code>) export task at a time. To cancel an export task, use <a>CancelExportTask</a>.</p> <p>You can export logs from multiple log groups or multiple time ranges to the same S3 bucket. To separate out log data for each export task, you can specify a prefix to be used as the Amazon S3 key prefix for all exported objects.</p>\"\
    },\
    \"CreateLogGroup\":{\
      \"name\":\"CreateLogGroup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateLogGroupRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceAlreadyExistsException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates a log group with the specified name.</p> <p>You can create up to 5000 log groups per account.</p> <p>You must use the following guidelines when naming a log group:</p> <ul> <li> <p>Log group names must be unique within a region for an AWS account.</p> </li> <li> <p>Log group names can be between 1 and 512 characters long.</p> </li> <li> <p>Log group names consist of the following characters: a-z, A-Z, 0-9, '_' (underscore), '-' (hyphen), '/' (forward slash), and '.' (period).</p> </li> </ul> <p>If you associate a AWS Key Management Service (AWS KMS) customer master key (CMK) with the log group, ingested data is encrypted using the CMK. This association is stored as long as the data encrypted with the CMK is still within Amazon CloudWatch Logs. This enables Amazon CloudWatch Logs to decrypt this data whenever it is requested.</p> <p>If you attempt to associate a CMK with the log group but the CMK does not exist or the CMK is disabled, you will receive an <code>InvalidParameterException</code> error. </p>\"\
    },\
    \"CreateLogStream\":{\
      \"name\":\"CreateLogStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateLogStreamRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceAlreadyExistsException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates a log stream for the specified log group.</p> <p>There is no limit on the number of log streams that you can create for a log group.</p> <p>You must use the following guidelines when naming a log stream:</p> <ul> <li> <p>Log stream names must be unique within the log group.</p> </li> <li> <p>Log stream names can be between 1 and 512 characters long.</p> </li> <li> <p>The ':' (colon) and '*' (asterisk) characters are not allowed.</p> </li> </ul>\"\
    },\
    \"DeleteDestination\":{\
      \"name\":\"DeleteDestination\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteDestinationRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified destination, and eventually disables all the subscription filters that publish to it. This operation does not delete the physical resource encapsulated by the destination.</p>\"\
    },\
    \"DeleteLogGroup\":{\
      \"name\":\"DeleteLogGroup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteLogGroupRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified log group and permanently deletes all the archived log events associated with the log group.</p>\"\
    },\
    \"DeleteLogStream\":{\
      \"name\":\"DeleteLogStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteLogStreamRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified log stream and permanently deletes all the archived log events associated with the log stream.</p>\"\
    },\
    \"DeleteMetricFilter\":{\
      \"name\":\"DeleteMetricFilter\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteMetricFilterRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified metric filter.</p>\"\
    },\
    \"DeleteResourcePolicy\":{\
      \"name\":\"DeleteResourcePolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteResourcePolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes a resource policy from this account. This revokes the access of the identities in that policy to put log events to this account.</p>\"\
    },\
    \"DeleteRetentionPolicy\":{\
      \"name\":\"DeleteRetentionPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteRetentionPolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified retention policy.</p> <p>Log events do not expire if they belong to log groups without a retention policy.</p>\"\
    },\
    \"DeleteSubscriptionFilter\":{\
      \"name\":\"DeleteSubscriptionFilter\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteSubscriptionFilterRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified subscription filter.</p>\"\
    },\
    \"DescribeDestinations\":{\
      \"name\":\"DescribeDestinations\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeDestinationsRequest\"},\
      \"output\":{\"shape\":\"DescribeDestinationsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists all your destinations. The results are ASCII-sorted by destination name.</p>\"\
    },\
    \"DescribeExportTasks\":{\
      \"name\":\"DescribeExportTasks\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeExportTasksRequest\"},\
      \"output\":{\"shape\":\"DescribeExportTasksResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the specified export tasks. You can list all your export tasks or filter the results based on task ID or task status.</p>\"\
    },\
    \"DescribeLogGroups\":{\
      \"name\":\"DescribeLogGroups\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeLogGroupsRequest\"},\
      \"output\":{\"shape\":\"DescribeLogGroupsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the specified log groups. You can list all your log groups or filter the results by prefix. The results are ASCII-sorted by log group name.</p>\"\
    },\
    \"DescribeLogStreams\":{\
      \"name\":\"DescribeLogStreams\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeLogStreamsRequest\"},\
      \"output\":{\"shape\":\"DescribeLogStreamsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the log streams for the specified log group. You can list all the log streams or filter the results by prefix. You can also control how the results are ordered.</p> <p>This operation has a limit of five transactions per second, after which transactions are throttled.</p>\"\
    },\
    \"DescribeMetricFilters\":{\
      \"name\":\"DescribeMetricFilters\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeMetricFiltersRequest\"},\
      \"output\":{\"shape\":\"DescribeMetricFiltersResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the specified metric filters. You can list all the metric filters or filter the results by log name, prefix, metric name, or metric namespace. The results are ASCII-sorted by filter name.</p>\"\
    },\
    \"DescribeQueries\":{\
      \"name\":\"DescribeQueries\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeQueriesRequest\"},\
      \"output\":{\"shape\":\"DescribeQueriesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of CloudWatch Logs Insights queries that are scheduled, executing, or have been executed recently in this account. You can request all queries, or limit it to queries of a specific log group or queries with a certain status.</p>\"\
    },\
    \"DescribeResourcePolicies\":{\
      \"name\":\"DescribeResourcePolicies\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeResourcePoliciesRequest\"},\
      \"output\":{\"shape\":\"DescribeResourcePoliciesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the resource policies in this account.</p>\"\
    },\
    \"DescribeSubscriptionFilters\":{\
      \"name\":\"DescribeSubscriptionFilters\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeSubscriptionFiltersRequest\"},\
      \"output\":{\"shape\":\"DescribeSubscriptionFiltersResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the subscription filters for the specified log group. You can list all the subscription filters or filter the results by prefix. The results are ASCII-sorted by filter name.</p>\"\
    },\
    \"DisassociateKmsKey\":{\
      \"name\":\"DisassociateKmsKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisassociateKmsKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Disassociates the associated AWS Key Management Service (AWS KMS) customer master key (CMK) from the specified log group.</p> <p>After the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested.</p> <p>Note that it can take up to 5 minutes for this operation to take effect.</p>\"\
    },\
    \"FilterLogEvents\":{\
      \"name\":\"FilterLogEvents\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"FilterLogEventsRequest\"},\
      \"output\":{\"shape\":\"FilterLogEventsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists log events from the specified log group. You can list all the log events or filter the results using a filter pattern, a time range, and the name of the log stream.</p> <p>By default, this operation returns as many log events as can fit in 1 MB (up to 10,000 log events), or all the events found within the time range that you specify. If the results include a token, then there are more log events available, and you can get additional results by specifying the token in a subsequent call.</p>\"\
    },\
    \"GetLogEvents\":{\
      \"name\":\"GetLogEvents\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetLogEventsRequest\"},\
      \"output\":{\"shape\":\"GetLogEventsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists log events from the specified log stream. You can list all the log events or filter using a time range.</p> <p>By default, this operation returns as many log events as can fit in a response size of 1MB (up to 10,000 log events). You can get additional log events by specifying one of the tokens in a subsequent call.</p>\"\
    },\
    \"GetLogGroupFields\":{\
      \"name\":\"GetLogGroupFields\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetLogGroupFieldsRequest\"},\
      \"output\":{\"shape\":\"GetLogGroupFieldsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of the fields that are included in log events in the specified log group, along with the percentage of log events that contain each field. The search is limited to a time period that you specify.</p> <p>In the results, fields that start with @ are fields generated by CloudWatch Logs. For example, <code>@timestamp</code> is the timestamp of each log event.</p> <p>The response results are sorted by the frequency percentage, starting with the highest percentage.</p>\"\
    },\
    \"GetLogRecord\":{\
      \"name\":\"GetLogRecord\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetLogRecordRequest\"},\
      \"output\":{\"shape\":\"GetLogRecordResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Retrieves all the fields and values of a single log event. All fields are retrieved, even if the original query that produced the <code>logRecordPointer</code> retrieved only a subset of fields. Fields are returned as field name/field value pairs.</p> <p>Additionally, the entire unparsed log event is returned within <code>@message</code>.</p>\"\
    },\
    \"GetQueryResults\":{\
      \"name\":\"GetQueryResults\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetQueryResultsRequest\"},\
      \"output\":{\"shape\":\"GetQueryResultsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Returns the results from the specified query. If the query is in progress, partial results of that current execution are returned. Only the fields requested in the query are returned.</p> <p> <code>GetQueryResults</code> does not start a query execution. To run a query, use .</p>\"\
    },\
    \"ListTagsLogGroup\":{\
      \"name\":\"ListTagsLogGroup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListTagsLogGroupRequest\"},\
      \"output\":{\"shape\":\"ListTagsLogGroupResponse\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Lists the tags for the specified log group.</p>\"\
    },\
    \"PutDestination\":{\
      \"name\":\"PutDestination\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutDestinationRequest\"},\
      \"output\":{\"shape\":\"PutDestinationResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates or updates a destination. A destination encapsulates a physical resource (such as an Amazon Kinesis stream) and enables you to subscribe to a real-time stream of log events for a different account, ingested using <a>PutLogEvents</a>. Currently, the only supported physical resource is a Kinesis stream belonging to the same account as the destination.</p> <p>Through an access policy, a destination controls what is written to its Kinesis stream. By default, <code>PutDestination</code> does not set any access policy with the destination, which means a cross-account user cannot call <a>PutSubscriptionFilter</a> against this destination. To enable this, the destination owner must call <a>PutDestinationPolicy</a> after <code>PutDestination</code>.</p>\"\
    },\
    \"PutDestinationPolicy\":{\
      \"name\":\"PutDestinationPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutDestinationPolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates or updates an access policy associated with an existing destination. An access policy is an <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/policies_overview.html\\\">IAM policy document</a> that is used to authorize claims to register a subscription filter against a given destination.</p>\"\
    },\
    \"PutLogEvents\":{\
      \"name\":\"PutLogEvents\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutLogEventsRequest\"},\
      \"output\":{\"shape\":\"PutLogEventsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"InvalidSequenceTokenException\"},\
        {\"shape\":\"DataAlreadyAcceptedException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"},\
        {\"shape\":\"UnrecognizedClientException\"}\
      ],\
      \"documentation\":\"<p>Uploads a batch of log events to the specified log stream.</p> <p>You must include the sequence token obtained from the response of the previous call. An upload in a newly created log stream does not require a sequence token. You can also get the sequence token using <a>DescribeLogStreams</a>. If you call <code>PutLogEvents</code> twice within a narrow time period using the same value for <code>sequenceToken</code>, both calls may be successful, or one may be rejected.</p> <p>The batch of events must satisfy the following constraints:</p> <ul> <li> <p>The maximum batch size is 1,048,576 bytes, and this size is calculated as the sum of all event messages in UTF-8, plus 26 bytes for each log event.</p> </li> <li> <p>None of the log events in the batch can be more than 2 hours in the future.</p> </li> <li> <p>None of the log events in the batch can be older than 14 days or the retention period of the log group.</p> </li> <li> <p>The log events in the batch must be in chronological ordered by their timestamp. The timestamp is the time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. (In AWS Tools for PowerShell and the AWS SDK for .NET, the timestamp is specified in .NET format: yyyy-mm-ddThh:mm:ss. For example, 2017-09-15T13:45:30.) </p> </li> <li> <p>The maximum number of log events in a batch is 10,000.</p> </li> <li> <p>A batch of log events in a single request cannot span more than 24 hours. Otherwise, the operation fails.</p> </li> </ul> <p>If a call to PutLogEvents returns \\\"UnrecognizedClientException\\\" the most likely cause is an invalid AWS access key ID or secret key. </p>\"\
    },\
    \"PutMetricFilter\":{\
      \"name\":\"PutMetricFilter\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutMetricFilterRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates or updates a metric filter and associates it with the specified log group. Metric filters allow you to configure rules to extract metric data from log events ingested through <a>PutLogEvents</a>.</p> <p>The maximum number of metric filters that can be associated with a log group is 100.</p>\"\
    },\
    \"PutResourcePolicy\":{\
      \"name\":\"PutResourcePolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutResourcePolicyRequest\"},\
      \"output\":{\"shape\":\"PutResourcePolicyResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates or updates a resource policy allowing other AWS services to put log events to this account, such as Amazon Route 53. An account can have up to 10 resource policies per region.</p>\"\
    },\
    \"PutRetentionPolicy\":{\
      \"name\":\"PutRetentionPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRetentionPolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Sets the retention of the specified log group. A retention policy allows you to configure the number of days for which to retain log events in the specified log group.</p>\"\
    },\
    \"PutSubscriptionFilter\":{\
      \"name\":\"PutSubscriptionFilter\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutSubscriptionFilterRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"OperationAbortedException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Creates or updates a subscription filter and associates it with the specified log group. Subscription filters allow you to subscribe to a real-time stream of log events ingested through <a>PutLogEvents</a> and have them delivered to a specific destination. Currently, the supported destinations are:</p> <ul> <li> <p>An Amazon Kinesis stream belonging to the same account as the subscription filter, for same-account delivery.</p> </li> <li> <p>A logical destination that belongs to a different account, for cross-account delivery.</p> </li> <li> <p>An Amazon Kinesis Firehose delivery stream that belongs to the same account as the subscription filter, for same-account delivery.</p> </li> <li> <p>An AWS Lambda function that belongs to the same account as the subscription filter, for same-account delivery.</p> </li> </ul> <p>There can only be one subscription filter associated with a log group. If you are updating an existing filter, you must specify the correct name in <code>filterName</code>. Otherwise, the call fails because you cannot associate a second filter with a log group.</p>\"\
    },\
    \"StartQuery\":{\
      \"name\":\"StartQuery\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"StartQueryRequest\"},\
      \"output\":{\"shape\":\"StartQueryResponse\"},\
      \"errors\":[\
        {\"shape\":\"MalformedQueryException\"},\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Schedules a query of a log group using CloudWatch Logs Insights. You specify the log group and time range to query, and the query string to use.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html\\\">CloudWatch Logs Insights Query Syntax</a>.</p>\"\
    },\
    \"StopQuery\":{\
      \"name\":\"StopQuery\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"StopQueryRequest\"},\
      \"output\":{\"shape\":\"StopQueryResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Stops a CloudWatch Logs Insights query that is in progress. If the query has already ended, the operation returns an error indicating that the specified query is not running.</p>\"\
    },\
    \"TagLogGroup\":{\
      \"name\":\"TagLogGroup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TagLogGroupRequest\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidParameterException\"}\
      ],\
      \"documentation\":\"<p>Adds or updates the specified tags for the specified log group.</p> <p>To list the tags for a log group, use <a>ListTagsLogGroup</a>. To remove tags, use <a>UntagLogGroup</a>.</p> <p>For more information about tags, see <a href=\\\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/log-group-tagging.html\\\">Tag Log Groups in Amazon CloudWatch Logs</a> in the <i>Amazon CloudWatch Logs User Guide</i>.</p>\"\
    },\
    \"TestMetricFilter\":{\
      \"name\":\"TestMetricFilter\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TestMetricFilterRequest\"},\
      \"output\":{\"shape\":\"TestMetricFilterResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Tests the filter pattern of a metric filter against a sample of log event messages. You can use this operation to validate the correctness of a metric filter pattern.</p>\"\
    },\
    \"UntagLogGroup\":{\
      \"name\":\"UntagLogGroup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UntagLogGroupRequest\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Removes the specified tags from the specified log group.</p> <p>To list the tags for a log group, use <a>ListTagsLogGroup</a>. To add tags, use <a>UntagLogGroup</a>.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AccessPolicy\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"Arn\":{\"type\":\"string\"},\
    \"AssociateKmsKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"kmsKeyId\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"kmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK to use when encrypting log data. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms\\\">Amazon Resource Names - AWS Key Management Service (AWS KMS)</a>.</p>\"\
        }\
      }\
    },\
    \"CancelExportTaskRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"taskId\"],\
      \"members\":{\
        \"taskId\":{\
          \"shape\":\"ExportTaskId\",\
          \"documentation\":\"<p>The ID of the export task.</p>\"\
        }\
      }\
    },\
    \"CreateExportTaskRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"from\",\
        \"to\",\
        \"destination\"\
      ],\
      \"members\":{\
        \"taskName\":{\
          \"shape\":\"ExportTaskName\",\
          \"documentation\":\"<p>The name of the export task.</p>\"\
        },\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamNamePrefix\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>Export only log streams that match the provided prefix. If you don't specify a value, no prefix filter is applied.</p>\"\
        },\
        \"from\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The start time of the range for the request, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp earlier than this time are not exported.</p>\"\
        },\
        \"to\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The end time of the range for the request, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp later than this time are not exported.</p>\"\
        },\
        \"destination\":{\
          \"shape\":\"ExportDestinationBucket\",\
          \"documentation\":\"<p>The name of S3 bucket for the exported log data. The bucket must be in the same AWS region.</p>\"\
        },\
        \"destinationPrefix\":{\
          \"shape\":\"ExportDestinationPrefix\",\
          \"documentation\":\"<p>The prefix used as the start of the key for every object exported. If you don't specify a value, the default is <code>exportedlogs</code>.</p>\"\
        }\
      }\
    },\
    \"CreateExportTaskResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"taskId\":{\
          \"shape\":\"ExportTaskId\",\
          \"documentation\":\"<p>The ID of the export task.</p>\"\
        }\
      }\
    },\
    \"CreateLogGroupRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"kmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK to use when encrypting log data. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms\\\">Amazon Resource Names - AWS Key Management Service (AWS KMS)</a>.</p>\"\
        },\
        \"tags\":{\
          \"shape\":\"Tags\",\
          \"documentation\":\"<p>The key-value pairs to use for the tags.</p>\"\
        }\
      }\
    },\
    \"CreateLogStreamRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"logStreamName\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        }\
      }\
    },\
    \"DataAlreadyAcceptedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"expectedSequenceToken\":{\"shape\":\"SequenceToken\"}\
      },\
      \"documentation\":\"<p>The event was already logged.</p>\",\
      \"exception\":true\
    },\
    \"Days\":{\
      \"type\":\"integer\",\
      \"documentation\":\"<p>The number of days to retain the log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653.</p>\"\
    },\
    \"DefaultValue\":{\"type\":\"double\"},\
    \"DeleteDestinationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"destinationName\"],\
      \"members\":{\
        \"destinationName\":{\
          \"shape\":\"DestinationName\",\
          \"documentation\":\"<p>The name of the destination.</p>\"\
        }\
      }\
    },\
    \"DeleteLogGroupRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        }\
      }\
    },\
    \"DeleteLogStreamRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"logStreamName\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        }\
      }\
    },\
    \"DeleteMetricFilterRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"filterName\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The name of the metric filter.</p>\"\
        }\
      }\
    },\
    \"DeleteResourcePolicyRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"policyName\":{\
          \"shape\":\"PolicyName\",\
          \"documentation\":\"<p>The name of the policy to be revoked. This parameter is required.</p>\"\
        }\
      }\
    },\
    \"DeleteRetentionPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        }\
      }\
    },\
    \"DeleteSubscriptionFilterRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"filterName\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The name of the subscription filter.</p>\"\
        }\
      }\
    },\
    \"Descending\":{\"type\":\"boolean\"},\
    \"DescribeDestinationsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DestinationNamePrefix\":{\
          \"shape\":\"DestinationName\",\
          \"documentation\":\"<p>The prefix to match. If you don't specify a value, no prefix filter is applied.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        }\
      }\
    },\
    \"DescribeDestinationsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"destinations\":{\
          \"shape\":\"Destinations\",\
          \"documentation\":\"<p>The destinations.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeExportTasksRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"taskId\":{\
          \"shape\":\"ExportTaskId\",\
          \"documentation\":\"<p>The ID of the export task. Specifying a task ID filters the results to zero or one export tasks.</p>\"\
        },\
        \"statusCode\":{\
          \"shape\":\"ExportTaskStatusCode\",\
          \"documentation\":\"<p>The status code of the export task. Specifying a status code filters the results to zero or more export tasks.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        }\
      }\
    },\
    \"DescribeExportTasksResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"exportTasks\":{\
          \"shape\":\"ExportTasks\",\
          \"documentation\":\"<p>The export tasks.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeLimit\":{\
      \"type\":\"integer\",\
      \"max\":50,\
      \"min\":1\
    },\
    \"DescribeLogGroupsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroupNamePrefix\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The prefix to match.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        }\
      }\
    },\
    \"DescribeLogGroupsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroups\":{\
          \"shape\":\"LogGroups\",\
          \"documentation\":\"<p>The log groups.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeLogStreamsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamNamePrefix\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The prefix to match.</p> <p>If <code>orderBy</code> is <code>LastEventTime</code>,you cannot specify this parameter.</p>\"\
        },\
        \"orderBy\":{\
          \"shape\":\"OrderBy\",\
          \"documentation\":\"<p>If the value is <code>LogStreamName</code>, the results are ordered by log stream name. If the value is <code>LastEventTime</code>, the results are ordered by the event time. The default value is <code>LogStreamName</code>.</p> <p>If you order the results by event time, you cannot specify the <code>logStreamNamePrefix</code> parameter.</p> <p>lastEventTimestamp represents the time of the most recent log event in the log stream in CloudWatch Logs. This number is expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. lastEventTimeStamp updates on an eventual consistency basis. It typically updates in less than an hour from ingestion, but may take longer in some rare situations.</p>\"\
        },\
        \"descending\":{\
          \"shape\":\"Descending\",\
          \"documentation\":\"<p>If the value is true, results are returned in descending order. If the value is to false, results are returned in ascending order. The default value is false.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        }\
      }\
    },\
    \"DescribeLogStreamsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logStreams\":{\
          \"shape\":\"LogStreams\",\
          \"documentation\":\"<p>The log streams.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeMetricFiltersRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterNamePrefix\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The prefix to match.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        },\
        \"metricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>Filters results to include only those with the specified metric name. If you include this parameter in your request, you must also include the <code>metricNamespace</code> parameter.</p>\"\
        },\
        \"metricNamespace\":{\
          \"shape\":\"MetricNamespace\",\
          \"documentation\":\"<p>Filters results to include only those in the specified namespace. If you include this parameter in your request, you must also include the <code>metricName</code> parameter.</p>\"\
        }\
      }\
    },\
    \"DescribeMetricFiltersResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"metricFilters\":{\
          \"shape\":\"MetricFilters\",\
          \"documentation\":\"<p>The metric filters.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeQueriesMaxResults\":{\
      \"type\":\"integer\",\
      \"max\":1000,\
      \"min\":1\
    },\
    \"DescribeQueriesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>Limits the returned queries to only those for the specified log group.</p>\"\
        },\
        \"status\":{\
          \"shape\":\"QueryStatus\",\
          \"documentation\":\"<p>Limits the returned queries to only those that have the specified status. Valid values are <code>Cancelled</code>, <code>Complete</code>, <code>Failed</code>, <code>Running</code>, and <code>Scheduled</code>.</p>\"\
        },\
        \"maxResults\":{\
          \"shape\":\"DescribeQueriesMaxResults\",\
          \"documentation\":\"<p>Limits the number of returned queries to the specified number.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeQueriesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"queries\":{\
          \"shape\":\"QueryInfoList\",\
          \"documentation\":\"<p>The list of queries that match the request.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeResourcePoliciesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"nextToken\":{\"shape\":\"NextToken\"},\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of resource policies to be displayed with one call of this API.</p>\"\
        }\
      }\
    },\
    \"DescribeResourcePoliciesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"resourcePolicies\":{\
          \"shape\":\"ResourcePolicies\",\
          \"documentation\":\"<p>The resource policies that exist in this account.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"DescribeSubscriptionFiltersRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterNamePrefix\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The prefix to match. If you don't specify a value, no prefix filter is applied.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"DescribeLimit\",\
          \"documentation\":\"<p>The maximum number of items returned. If you don't specify a value, the default is up to 50 items.</p>\"\
        }\
      }\
    },\
    \"DescribeSubscriptionFiltersResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"subscriptionFilters\":{\
          \"shape\":\"SubscriptionFilters\",\
          \"documentation\":\"<p>The subscription filters.</p>\"\
        },\
        \"nextToken\":{\"shape\":\"NextToken\"}\
      }\
    },\
    \"Destination\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"destinationName\":{\
          \"shape\":\"DestinationName\",\
          \"documentation\":\"<p>The name of the destination.</p>\"\
        },\
        \"targetArn\":{\
          \"shape\":\"TargetArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the physical target to where the log events are delivered (for example, a Kinesis stream).</p>\"\
        },\
        \"roleArn\":{\
          \"shape\":\"RoleArn\",\
          \"documentation\":\"<p>A role for impersonation, used when delivering log events to the target.</p>\"\
        },\
        \"accessPolicy\":{\
          \"shape\":\"AccessPolicy\",\
          \"documentation\":\"<p>An IAM policy document that governs which AWS accounts can create subscription filters against this destination.</p>\"\
        },\
        \"arn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The ARN of this destination.</p>\"\
        },\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a cross-account destination that receives subscription log events.</p>\"\
    },\
    \"DestinationArn\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"DestinationName\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"[^:*]*\"\
    },\
    \"Destinations\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Destination\"}\
    },\
    \"DisassociateKmsKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        }\
      }\
    },\
    \"Distribution\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The method used to distribute log data to the destination, which can be either random or grouped by log stream.</p>\",\
      \"enum\":[\
        \"Random\",\
        \"ByLogStream\"\
      ]\
    },\
    \"EventId\":{\"type\":\"string\"},\
    \"EventMessage\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"EventNumber\":{\"type\":\"long\"},\
    \"EventsLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"ExportDestinationBucket\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1\
    },\
    \"ExportDestinationPrefix\":{\"type\":\"string\"},\
    \"ExportTask\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"taskId\":{\
          \"shape\":\"ExportTaskId\",\
          \"documentation\":\"<p>The ID of the export task.</p>\"\
        },\
        \"taskName\":{\
          \"shape\":\"ExportTaskName\",\
          \"documentation\":\"<p>The name of the export task.</p>\"\
        },\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group from which logs data was exported.</p>\"\
        },\
        \"from\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The start time, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp before this time are not exported.</p>\"\
        },\
        \"to\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The end time, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp later than this time are not exported.</p>\"\
        },\
        \"destination\":{\
          \"shape\":\"ExportDestinationBucket\",\
          \"documentation\":\"<p>The name of Amazon S3 bucket to which the log data was exported.</p>\"\
        },\
        \"destinationPrefix\":{\
          \"shape\":\"ExportDestinationPrefix\",\
          \"documentation\":\"<p>The prefix that was used as the start of Amazon S3 key for every object exported.</p>\"\
        },\
        \"status\":{\
          \"shape\":\"ExportTaskStatus\",\
          \"documentation\":\"<p>The status of the export task.</p>\"\
        },\
        \"executionInfo\":{\
          \"shape\":\"ExportTaskExecutionInfo\",\
          \"documentation\":\"<p>Execution info about the export task.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents an export task.</p>\"\
    },\
    \"ExportTaskExecutionInfo\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the export task, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"completionTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The completion time of the export task, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the status of an export task.</p>\"\
    },\
    \"ExportTaskId\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1\
    },\
    \"ExportTaskName\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1\
    },\
    \"ExportTaskStatus\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"code\":{\
          \"shape\":\"ExportTaskStatusCode\",\
          \"documentation\":\"<p>The status code of the export task.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"ExportTaskStatusMessage\",\
          \"documentation\":\"<p>The status message related to the status code.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the status of an export task.</p>\"\
    },\
    \"ExportTaskStatusCode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CANCELLED\",\
        \"COMPLETED\",\
        \"FAILED\",\
        \"PENDING\",\
        \"PENDING_CANCEL\",\
        \"RUNNING\"\
      ]\
    },\
    \"ExportTaskStatusMessage\":{\"type\":\"string\"},\
    \"ExportTasks\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ExportTask\"}\
    },\
    \"ExtractedValues\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"Token\"},\
      \"value\":{\"shape\":\"Value\"}\
    },\
    \"Field\":{\"type\":\"string\"},\
    \"FilterCount\":{\"type\":\"integer\"},\
    \"FilterLogEventsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group to search.</p>\"\
        },\
        \"logStreamNames\":{\
          \"shape\":\"InputLogStreamNames\",\
          \"documentation\":\"<p>Filters the results to only logs from the log streams in this list.</p> <p>If you specify a value for both <code>logStreamNamePrefix</code> and <code>logStreamNames</code>, the action returns an <code>InvalidParameterException</code> error.</p>\"\
        },\
        \"logStreamNamePrefix\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>Filters the results to include only events from log streams that have names starting with this prefix.</p> <p>If you specify a value for both <code>logStreamNamePrefix</code> and <code>logStreamNames</code>, but the value for <code>logStreamNamePrefix</code> does not match any log stream names specified in <code>logStreamNames</code>, the action returns an <code>InvalidParameterException</code> error.</p>\"\
        },\
        \"startTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The start of the time range, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp before this time are not returned.</p>\"\
        },\
        \"endTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The end of the time range, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp later than this time are not returned.</p>\"\
        },\
        \"filterPattern\":{\
          \"shape\":\"FilterPattern\",\
          \"documentation\":\"<p>The filter pattern to use. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html\\\">Filter and Pattern Syntax</a>.</p> <p>If not provided, all the events are matched.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of events to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"EventsLimit\",\
          \"documentation\":\"<p>The maximum number of events to return. The default is 10,000 events.</p>\"\
        },\
        \"interleaved\":{\
          \"shape\":\"Interleaved\",\
          \"documentation\":\"<p>If the value is true, the operation makes a best effort to provide responses that contain events from multiple log streams within the log group, interleaved in a single response. If the value is false, all the matched log events in the first log stream are searched first, then those in the next log stream, and so on. The default is false.</p>\"\
        }\
      }\
    },\
    \"FilterLogEventsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"events\":{\
          \"shape\":\"FilteredLogEvents\",\
          \"documentation\":\"<p>The matched events.</p>\"\
        },\
        \"searchedLogStreams\":{\
          \"shape\":\"SearchedLogStreams\",\
          \"documentation\":\"<p>Indicates which log streams have been searched and whether each has been searched completely.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token to use when requesting the next set of items. The token expires after 24 hours.</p>\"\
        }\
      }\
    },\
    \"FilterName\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"[^:*]*\"\
    },\
    \"FilterPattern\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event may contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message.</p>\",\
      \"max\":1024,\
      \"min\":0\
    },\
    \"FilteredLogEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream to which this event belongs.</p>\"\
        },\
        \"timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"EventMessage\",\
          \"documentation\":\"<p>The data contained in the log event.</p>\"\
        },\
        \"ingestionTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time the event was ingested, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"eventId\":{\
          \"shape\":\"EventId\",\
          \"documentation\":\"<p>The ID of the event.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a matched event.</p>\"\
    },\
    \"FilteredLogEvents\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"FilteredLogEvent\"}\
    },\
    \"GetLogEventsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"logStreamName\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        },\
        \"startTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The start of the time range, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp equal to this time or later than this time are included. Events with a timestamp earlier than this time are not included.</p>\"\
        },\
        \"endTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The end of the time range, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. Events with a timestamp equal to or later than this time are not included.</p>\"\
        },\
        \"nextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items to return. (You received this token from a previous call.)</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"EventsLimit\",\
          \"documentation\":\"<p>The maximum number of log events returned. If you don't specify a value, the maximum is as many log events as can fit in a response size of 1 MB, up to 10,000 log events.</p>\"\
        },\
        \"startFromHead\":{\
          \"shape\":\"StartFromHead\",\
          \"documentation\":\"<p>If the value is true, the earliest log events are returned first. If the value is false, the latest log events are returned first. The default value is false.</p>\"\
        }\
      }\
    },\
    \"GetLogEventsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"events\":{\
          \"shape\":\"OutputLogEvents\",\
          \"documentation\":\"<p>The events.</p>\"\
        },\
        \"nextForwardToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items in the forward direction. The token expires after 24 hours. If you have reached the end of the stream, it will return the same token you passed in.</p>\"\
        },\
        \"nextBackwardToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token for the next set of items in the backward direction. The token expires after 24 hours. This token will never be null. If you have reached the end of the stream, it will return the same token you passed in.</p>\"\
        }\
      }\
    },\
    \"GetLogGroupFieldsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group to search.</p>\"\
        },\
        \"time\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time to set as the center of the query. If you specify <code>time</code>, the 8 minutes before and 8 minutes after this time are searched. If you omit <code>time</code>, the past 15 minutes are queried.</p> <p>The <code>time</code> value is specified as epoch time, the number of seconds since January 1, 1970, 00:00:00 UTC.</p>\"\
        }\
      }\
    },\
    \"GetLogGroupFieldsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroupFields\":{\
          \"shape\":\"LogGroupFieldList\",\
          \"documentation\":\"<p>The array of fields found in the query. Each object in the array contains the name of the field, along with the percentage of time it appeared in the log events that were queried.</p>\"\
        }\
      }\
    },\
    \"GetLogRecordRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logRecordPointer\"],\
      \"members\":{\
        \"logRecordPointer\":{\
          \"shape\":\"LogRecordPointer\",\
          \"documentation\":\"<p>The pointer corresponding to the log event record you want to retrieve. You get this from the response of a <code>GetQueryResults</code> operation. In that response, the value of the <code>@ptr</code> field for a log event is the value to use as <code>logRecordPointer</code> to retrieve that complete log event record.</p>\"\
        }\
      }\
    },\
    \"GetLogRecordResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logRecord\":{\
          \"shape\":\"LogRecord\",\
          \"documentation\":\"<p>The requested log event, as a JSON string.</p>\"\
        }\
      }\
    },\
    \"GetQueryResultsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"queryId\"],\
      \"members\":{\
        \"queryId\":{\
          \"shape\":\"QueryId\",\
          \"documentation\":\"<p>The ID number of the query.</p>\"\
        }\
      }\
    },\
    \"GetQueryResultsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"results\":{\
          \"shape\":\"QueryResults\",\
          \"documentation\":\"<p>The log events that matched the query criteria during the most recent time it ran.</p> <p>The <code>results</code> value is an array of arrays. Each log event is one object in the top-level array. Each of these log event objects is an array of <code>field</code>/<code>value</code> pairs.</p>\"\
        },\
        \"statistics\":{\
          \"shape\":\"QueryStatistics\",\
          \"documentation\":\"<p>Includes the number of log events scanned by the query, the number of log events that matched the query criteria, and the total number of bytes in the log events that were scanned.</p>\"\
        },\
        \"status\":{\
          \"shape\":\"QueryStatus\",\
          \"documentation\":\"<p>The status of the most recent running of the query. Possible values are <code>Cancelled</code>, <code>Complete</code>, <code>Failed</code>, <code>Running</code>, <code>Scheduled</code>, and <code>Unknown</code>.</p>\"\
        }\
      }\
    },\
    \"InputLogEvent\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"timestamp\",\
        \"message\"\
      ],\
      \"members\":{\
        \"timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"EventMessage\",\
          \"documentation\":\"<p>The raw event message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a log event, which is a record of activity that was recorded by the application or resource being monitored.</p>\"\
    },\
    \"InputLogEvents\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"InputLogEvent\"},\
      \"max\":10000,\
      \"min\":1\
    },\
    \"InputLogStreamNames\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LogStreamName\"},\
      \"max\":100,\
      \"min\":1\
    },\
    \"Interleaved\":{\"type\":\"boolean\"},\
    \"InvalidOperationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The operation is not valid on the specified resource.</p>\",\
      \"exception\":true\
    },\
    \"InvalidParameterException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>A parameter is specified incorrectly.</p>\",\
      \"exception\":true\
    },\
    \"InvalidSequenceTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"expectedSequenceToken\":{\"shape\":\"SequenceToken\"}\
      },\
      \"documentation\":\"<p>The sequence token is not valid.</p>\",\
      \"exception\":true\
    },\
    \"KmsKeyId\":{\
      \"type\":\"string\",\
      \"max\":256\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>You have reached the maximum number of resources that can be created.</p>\",\
      \"exception\":true\
    },\
    \"ListTagsLogGroupRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"logGroupName\"],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        }\
      }\
    },\
    \"ListTagsLogGroupResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"tags\":{\
          \"shape\":\"Tags\",\
          \"documentation\":\"<p>The tags for the log group.</p>\"\
        }\
      }\
    },\
    \"LogEventIndex\":{\"type\":\"integer\"},\
    \"LogGroup\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the log group, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"retentionInDays\":{\"shape\":\"Days\"},\
        \"metricFilterCount\":{\
          \"shape\":\"FilterCount\",\
          \"documentation\":\"<p>The number of metric filters.</p>\"\
        },\
        \"arn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the log group.</p>\"\
        },\
        \"storedBytes\":{\
          \"shape\":\"StoredBytes\",\
          \"documentation\":\"<p>The number of bytes stored.</p>\"\
        },\
        \"kmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK to use when encrypting log data.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a log group.</p>\"\
    },\
    \"LogGroupField\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"name\":{\
          \"shape\":\"Field\",\
          \"documentation\":\"<p>The name of a log field.</p>\"\
        },\
        \"percent\":{\
          \"shape\":\"Percentage\",\
          \"documentation\":\"<p>The percentage of log events queried that contained the field.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The fields contained in log events found by a <code>GetLogGroupFields</code> operation, along with the percentage of queried log events in which each field appears.</p>\"\
    },\
    \"LogGroupFieldList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LogGroupField\"}\
    },\
    \"LogGroupName\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"[\\\\.\\\\-_/#A-Za-z0-9]+\"\
    },\
    \"LogGroups\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LogGroup\"}\
    },\
    \"LogRecord\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"Field\"},\
      \"value\":{\"shape\":\"Value\"}\
    },\
    \"LogRecordPointer\":{\"type\":\"string\"},\
    \"LogStream\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        },\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the stream, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"firstEventTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time of the first event, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"lastEventTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time of the most recent log event in the log stream in CloudWatch Logs. This number is expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. The <code>lastEventTime</code> value updates on an eventual consistency basis. It typically updates in less than an hour from ingestion, but may take longer in some rare situations.</p>\"\
        },\
        \"lastIngestionTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The ingestion time, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"uploadSequenceToken\":{\
          \"shape\":\"SequenceToken\",\
          \"documentation\":\"<p>The sequence token.</p>\"\
        },\
        \"arn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the log stream.</p>\"\
        },\
        \"storedBytes\":{\
          \"shape\":\"StoredBytes\",\
          \"documentation\":\"<p>The number of bytes stored.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a log stream, which is a sequence of log events from a single emitter of logs.</p>\"\
    },\
    \"LogStreamName\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"[^:*]*\"\
    },\
    \"LogStreamSearchedCompletely\":{\"type\":\"boolean\"},\
    \"LogStreams\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LogStream\"}\
    },\
    \"MalformedQueryException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"queryCompileError\":{\"shape\":\"QueryCompileError\"}\
      },\
      \"documentation\":\"<p>The query string is not valid. Details about this error are displayed in a <code>QueryCompileError</code> object. For more information, see .</p> <p>For more information about valid query syntax, see <a href=\\\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html\\\">CloudWatch Logs Insights Query Syntax</a>.</p>\",\
      \"exception\":true\
    },\
    \"Message\":{\"type\":\"string\"},\
    \"MetricFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The name of the metric filter.</p>\"\
        },\
        \"filterPattern\":{\"shape\":\"FilterPattern\"},\
        \"metricTransformations\":{\
          \"shape\":\"MetricTransformations\",\
          \"documentation\":\"<p>The metric transformations.</p>\"\
        },\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the metric filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Metric filters express how CloudWatch Logs would extract metric observations from ingested log events and transform them into metric data in a CloudWatch metric.</p>\"\
    },\
    \"MetricFilterMatchRecord\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"eventNumber\":{\
          \"shape\":\"EventNumber\",\
          \"documentation\":\"<p>The event number.</p>\"\
        },\
        \"eventMessage\":{\
          \"shape\":\"EventMessage\",\
          \"documentation\":\"<p>The raw event data.</p>\"\
        },\
        \"extractedValues\":{\
          \"shape\":\"ExtractedValues\",\
          \"documentation\":\"<p>The values extracted from the event data by the filter.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a matched event.</p>\"\
    },\
    \"MetricFilterMatches\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricFilterMatchRecord\"}\
    },\
    \"MetricFilters\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricFilter\"}\
    },\
    \"MetricName\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The name of the CloudWatch metric to which the monitored log information should be published. For example, you may publish to a metric called ErrorCount.</p>\",\
      \"max\":255,\
      \"pattern\":\"[^:*$]*\"\
    },\
    \"MetricNamespace\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"pattern\":\"[^:*$]*\"\
    },\
    \"MetricTransformation\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"metricName\",\
        \"metricNamespace\",\
        \"metricValue\"\
      ],\
      \"members\":{\
        \"metricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the CloudWatch metric.</p>\"\
        },\
        \"metricNamespace\":{\
          \"shape\":\"MetricNamespace\",\
          \"documentation\":\"<p>The namespace of the CloudWatch metric.</p>\"\
        },\
        \"metricValue\":{\
          \"shape\":\"MetricValue\",\
          \"documentation\":\"<p>The value to publish to the CloudWatch metric when a filter pattern matches a log event.</p>\"\
        },\
        \"defaultValue\":{\
          \"shape\":\"DefaultValue\",\
          \"documentation\":\"<p>(Optional) The value to emit when a filter pattern does not match a log event. This value can be null.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Indicates how to transform ingested log eventsto metric data in a CloudWatch metric.</p>\"\
    },\
    \"MetricTransformations\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricTransformation\"},\
      \"max\":1,\
      \"min\":1\
    },\
    \"MetricValue\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The value to publish to the CloudWatch metric. For example, if you're counting the occurrences of a term like \\\"Error\\\", the value is \\\"1\\\" for each occurrence. If you're counting the bytes transferred, the value is the value in the log event.</p>\",\
      \"max\":100\
    },\
    \"NextToken\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The token for the next set of items to return. The token expires after 24 hours.</p>\",\
      \"min\":1\
    },\
    \"OperationAbortedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Multiple requests to update the same resource were in conflict.</p>\",\
      \"exception\":true\
    },\
    \"OrderBy\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"LogStreamName\",\
        \"LastEventTime\"\
      ]\
    },\
    \"OutputLogEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"EventMessage\",\
          \"documentation\":\"<p>The data contained in the log event.</p>\"\
        },\
        \"ingestionTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time the event was ingested, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a log event.</p>\"\
    },\
    \"OutputLogEvents\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"OutputLogEvent\"}\
    },\
    \"Percentage\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":0\
    },\
    \"PolicyDocument\":{\
      \"type\":\"string\",\
      \"max\":5120,\
      \"min\":1\
    },\
    \"PolicyName\":{\"type\":\"string\"},\
    \"PutDestinationPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"destinationName\",\
        \"accessPolicy\"\
      ],\
      \"members\":{\
        \"destinationName\":{\
          \"shape\":\"DestinationName\",\
          \"documentation\":\"<p>A name for an existing destination.</p>\"\
        },\
        \"accessPolicy\":{\
          \"shape\":\"AccessPolicy\",\
          \"documentation\":\"<p>An IAM policy document that authorizes cross-account users to deliver their log events to the associated destination.</p>\"\
        }\
      }\
    },\
    \"PutDestinationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"destinationName\",\
        \"targetArn\",\
        \"roleArn\"\
      ],\
      \"members\":{\
        \"destinationName\":{\
          \"shape\":\"DestinationName\",\
          \"documentation\":\"<p>A name for the destination.</p>\"\
        },\
        \"targetArn\":{\
          \"shape\":\"TargetArn\",\
          \"documentation\":\"<p>The ARN of an Amazon Kinesis stream to which to deliver matching log events.</p>\"\
        },\
        \"roleArn\":{\
          \"shape\":\"RoleArn\",\
          \"documentation\":\"<p>The ARN of an IAM role that grants CloudWatch Logs permissions to call the Amazon Kinesis PutRecord operation on the destination stream.</p>\"\
        }\
      }\
    },\
    \"PutDestinationResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"destination\":{\
          \"shape\":\"Destination\",\
          \"documentation\":\"<p>The destination.</p>\"\
        }\
      }\
    },\
    \"PutLogEventsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"logStreamName\",\
        \"logEvents\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        },\
        \"logEvents\":{\
          \"shape\":\"InputLogEvents\",\
          \"documentation\":\"<p>The log events.</p>\"\
        },\
        \"sequenceToken\":{\
          \"shape\":\"SequenceToken\",\
          \"documentation\":\"<p>The sequence token obtained from the response of the previous <code>PutLogEvents</code> call. An upload in a newly created log stream does not require a sequence token. You can also get the sequence token using <a>DescribeLogStreams</a>. If you call <code>PutLogEvents</code> twice within a narrow time period using the same value for <code>sequenceToken</code>, both calls may be successful, or one may be rejected.</p>\"\
        }\
      }\
    },\
    \"PutLogEventsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"nextSequenceToken\":{\
          \"shape\":\"SequenceToken\",\
          \"documentation\":\"<p>The next sequence token.</p>\"\
        },\
        \"rejectedLogEventsInfo\":{\
          \"shape\":\"RejectedLogEventsInfo\",\
          \"documentation\":\"<p>The rejected events.</p>\"\
        }\
      }\
    },\
    \"PutMetricFilterRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"filterName\",\
        \"filterPattern\",\
        \"metricTransformations\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>A name for the metric filter.</p>\"\
        },\
        \"filterPattern\":{\
          \"shape\":\"FilterPattern\",\
          \"documentation\":\"<p>A filter pattern for extracting metric data out of ingested log events.</p>\"\
        },\
        \"metricTransformations\":{\
          \"shape\":\"MetricTransformations\",\
          \"documentation\":\"<p>A collection of information that defines how metric data gets emitted.</p>\"\
        }\
      }\
    },\
    \"PutResourcePolicyRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"policyName\":{\
          \"shape\":\"PolicyName\",\
          \"documentation\":\"<p>Name of the new policy. This parameter is required.</p>\"\
        },\
        \"policyDocument\":{\
          \"shape\":\"PolicyDocument\",\
          \"documentation\":\"<p>Details of the new policy, including the identity of the principal that is enabled to put logs to this account. This is formatted as a JSON string.</p> <p>The following example creates a resource policy enabling the Route 53 service to put DNS query logs in to the specified log group. Replace \\\"logArn\\\" with the ARN of your CloudWatch Logs resource, such as a log group or log stream.</p> <p> <code>{ \\\"Version\\\": \\\"2012-10-17\\\", \\\"Statement\\\": [ { \\\"Sid\\\": \\\"Route53LogsToCloudWatchLogs\\\", \\\"Effect\\\": \\\"Allow\\\", \\\"Principal\\\": { \\\"Service\\\": [ \\\"route53.amazonaws.com\\\" ] }, \\\"Action\\\":\\\"logs:PutLogEvents\\\", \\\"Resource\\\": \\\"logArn\\\" } ] } </code> </p>\"\
        }\
      }\
    },\
    \"PutResourcePolicyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"resourcePolicy\":{\
          \"shape\":\"ResourcePolicy\",\
          \"documentation\":\"<p>The new policy.</p>\"\
        }\
      }\
    },\
    \"PutRetentionPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"retentionInDays\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"retentionInDays\":{\"shape\":\"Days\"}\
      }\
    },\
    \"PutSubscriptionFilterRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"filterName\",\
        \"filterPattern\",\
        \"destinationArn\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>A name for the subscription filter. If you are updating an existing filter, you must specify the correct name in <code>filterName</code>. Otherwise, the call fails because you cannot associate a second filter with a log group. To find the name of the filter currently associated with a log group, use <a>DescribeSubscriptionFilters</a>.</p>\"\
        },\
        \"filterPattern\":{\
          \"shape\":\"FilterPattern\",\
          \"documentation\":\"<p>A filter pattern for subscribing to a filtered stream of log events.</p>\"\
        },\
        \"destinationArn\":{\
          \"shape\":\"DestinationArn\",\
          \"documentation\":\"<p>The ARN of the destination to deliver matching log events to. Currently, the supported destinations are:</p> <ul> <li> <p>An Amazon Kinesis stream belonging to the same account as the subscription filter, for same-account delivery.</p> </li> <li> <p>A logical destination (specified using an ARN) belonging to a different account, for cross-account delivery.</p> </li> <li> <p>An Amazon Kinesis Firehose delivery stream belonging to the same account as the subscription filter, for same-account delivery.</p> </li> <li> <p>An AWS Lambda function belonging to the same account as the subscription filter, for same-account delivery.</p> </li> </ul>\"\
        },\
        \"roleArn\":{\
          \"shape\":\"RoleArn\",\
          \"documentation\":\"<p>The ARN of an IAM role that grants CloudWatch Logs permissions to deliver ingested log events to the destination stream. You don't need to provide the ARN when you are working with a logical destination for cross-account delivery.</p>\"\
        },\
        \"distribution\":{\
          \"shape\":\"Distribution\",\
          \"documentation\":\"<p>The method used to distribute log data to the destination. By default log data is grouped by log stream, but the grouping can be set to random for a more even distribution. This property is only applicable when the destination is an Amazon Kinesis stream. </p>\"\
        }\
      }\
    },\
    \"QueryCharOffset\":{\"type\":\"integer\"},\
    \"QueryCompileError\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"location\":{\
          \"shape\":\"QueryCompileErrorLocation\",\
          \"documentation\":\"<p>Reserved.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"Message\",\
          \"documentation\":\"<p>Reserved.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Reserved.</p>\"\
    },\
    \"QueryCompileErrorLocation\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"startCharOffset\":{\
          \"shape\":\"QueryCharOffset\",\
          \"documentation\":\"<p>Reserved.</p>\"\
        },\
        \"endCharOffset\":{\
          \"shape\":\"QueryCharOffset\",\
          \"documentation\":\"<p>Reserved.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Reserved.</p>\"\
    },\
    \"QueryId\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"QueryInfo\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"queryId\":{\
          \"shape\":\"QueryId\",\
          \"documentation\":\"<p>The unique ID number of this query.</p>\"\
        },\
        \"queryString\":{\
          \"shape\":\"QueryString\",\
          \"documentation\":\"<p>The query string used in this query.</p>\"\
        },\
        \"status\":{\
          \"shape\":\"QueryStatus\",\
          \"documentation\":\"<p>The status of this query. Possible values are <code>Cancelled</code>, <code>Complete</code>, <code>Failed</code>, <code>Running</code>, <code>Scheduled</code>, and <code>Unknown</code>.</p>\"\
        },\
        \"createTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The date and time that this query was created.</p>\"\
        },\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group scanned by this query.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Information about one CloudWatch Logs Insights query that matches the request in a <code>DescribeQueries</code> operation. </p>\"\
    },\
    \"QueryInfoList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"QueryInfo\"}\
    },\
    \"QueryResults\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ResultRows\"}\
    },\
    \"QueryStatistics\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"recordsMatched\":{\
          \"shape\":\"StatsValue\",\
          \"documentation\":\"<p>The number of log events that matched the query string.</p>\"\
        },\
        \"recordsScanned\":{\
          \"shape\":\"StatsValue\",\
          \"documentation\":\"<p>The total number of log events scanned during the query.</p>\"\
        },\
        \"bytesScanned\":{\
          \"shape\":\"StatsValue\",\
          \"documentation\":\"<p>The total number of bytes in the log events scanned during the query.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the number of log events scanned by the query, the number of log events that matched the query criteria, and the total number of bytes in the log events that were scanned.</p>\"\
    },\
    \"QueryStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Scheduled\",\
        \"Running\",\
        \"Complete\",\
        \"Failed\",\
        \"Cancelled\"\
      ]\
    },\
    \"QueryString\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":0\
    },\
    \"RejectedLogEventsInfo\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"tooNewLogEventStartIndex\":{\
          \"shape\":\"LogEventIndex\",\
          \"documentation\":\"<p>The log events that are too new.</p>\"\
        },\
        \"tooOldLogEventEndIndex\":{\
          \"shape\":\"LogEventIndex\",\
          \"documentation\":\"<p>The log events that are too old.</p>\"\
        },\
        \"expiredLogEventEndIndex\":{\
          \"shape\":\"LogEventIndex\",\
          \"documentation\":\"<p>The expired log events.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the rejected events.</p>\"\
    },\
    \"ResourceAlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The specified resource already exists.</p>\",\
      \"exception\":true\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The specified resource does not exist.</p>\",\
      \"exception\":true\
    },\
    \"ResourcePolicies\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ResourcePolicy\"}\
    },\
    \"ResourcePolicy\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"policyName\":{\
          \"shape\":\"PolicyName\",\
          \"documentation\":\"<p>The name of the resource policy.</p>\"\
        },\
        \"policyDocument\":{\
          \"shape\":\"PolicyDocument\",\
          \"documentation\":\"<p>The details of the policy.</p>\"\
        },\
        \"lastUpdatedTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Timestamp showing when this policy was last updated, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A policy enabling one or more entities to put logs to a log group in this account.</p>\"\
    },\
    \"ResultField\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"field\":{\
          \"shape\":\"Field\",\
          \"documentation\":\"<p>The log event field.</p>\"\
        },\
        \"value\":{\
          \"shape\":\"Value\",\
          \"documentation\":\"<p>The value of this field.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains one field from one log event returned by a CloudWatch Logs Insights query, along with the value of that field.</p>\"\
    },\
    \"ResultRows\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ResultField\"}\
    },\
    \"RoleArn\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"SearchedLogStream\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"logStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The name of the log stream.</p>\"\
        },\
        \"searchedCompletely\":{\
          \"shape\":\"LogStreamSearchedCompletely\",\
          \"documentation\":\"<p>Indicates whether all the events in this log stream were searched.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the search status of a log stream.</p>\"\
    },\
    \"SearchedLogStreams\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SearchedLogStream\"}\
    },\
    \"SequenceToken\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"ServiceUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The service cannot complete the request.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"StartFromHead\":{\"type\":\"boolean\"},\
    \"StartQueryRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"startTime\",\
        \"endTime\",\
        \"queryString\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The log group on which to perform the query.</p>\"\
        },\
        \"startTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The beginning of the time range to query. The range is inclusive, so the specified start time is included in the query. Specified as epoch time, the number of seconds since January 1, 1970, 00:00:00 UTC.</p>\"\
        },\
        \"endTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The end of the time range to query. The range is inclusive, so the specified end time is included in the query. Specified as epoch time, the number of seconds since January 1, 1970, 00:00:00 UTC.</p>\"\
        },\
        \"queryString\":{\
          \"shape\":\"QueryString\",\
          \"documentation\":\"<p>The query string to use. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html\\\">CloudWatch Logs Insights Query Syntax</a>.</p>\"\
        },\
        \"limit\":{\
          \"shape\":\"EventsLimit\",\
          \"documentation\":\"<p>The maximum number of log events to return in the query. If the query string uses the <code>fields</code> command, only the specified fields and their values are returned.</p>\"\
        }\
      }\
    },\
    \"StartQueryResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"queryId\":{\
          \"shape\":\"QueryId\",\
          \"documentation\":\"<p>The unique ID of the query. </p>\"\
        }\
      }\
    },\
    \"StatsValue\":{\"type\":\"double\"},\
    \"StopQueryRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"queryId\"],\
      \"members\":{\
        \"queryId\":{\
          \"shape\":\"QueryId\",\
          \"documentation\":\"<p>The ID number of the query to stop. If necessary, you can use <code>DescribeQueries</code> to find this ID number.</p>\"\
        }\
      }\
    },\
    \"StopQueryResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"success\":{\
          \"shape\":\"Success\",\
          \"documentation\":\"<p>This is true if the query was stopped by the <code>StopQuery</code> operation.</p>\"\
        }\
      }\
    },\
    \"StoredBytes\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"SubscriptionFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"filterName\":{\
          \"shape\":\"FilterName\",\
          \"documentation\":\"<p>The name of the subscription filter.</p>\"\
        },\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"filterPattern\":{\"shape\":\"FilterPattern\"},\
        \"destinationArn\":{\
          \"shape\":\"DestinationArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the destination.</p>\"\
        },\
        \"roleArn\":{\
          \"shape\":\"RoleArn\",\
          \"documentation\":\"<p/>\"\
        },\
        \"distribution\":{\"shape\":\"Distribution\"},\
        \"creationTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The creation time of the subscription filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a subscription filter.</p>\"\
    },\
    \"SubscriptionFilters\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SubscriptionFilter\"}\
    },\
    \"Success\":{\"type\":\"boolean\"},\
    \"TagKey\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]+)$\"\
    },\
    \"TagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKey\"},\
      \"min\":1\
    },\
    \"TagLogGroupRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"tags\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"tags\":{\
          \"shape\":\"Tags\",\
          \"documentation\":\"<p>The key-value pairs to use for the tags.</p>\"\
        }\
      }\
    },\
    \"TagValue\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"pattern\":\"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]*)$\"\
    },\
    \"Tags\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TagKey\"},\
      \"value\":{\"shape\":\"TagValue\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"TargetArn\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"TestEventMessages\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"EventMessage\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"TestMetricFilterRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"filterPattern\",\
        \"logEventMessages\"\
      ],\
      \"members\":{\
        \"filterPattern\":{\"shape\":\"FilterPattern\"},\
        \"logEventMessages\":{\
          \"shape\":\"TestEventMessages\",\
          \"documentation\":\"<p>The log event messages to test.</p>\"\
        }\
      }\
    },\
    \"TestMetricFilterResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"matches\":{\
          \"shape\":\"MetricFilterMatches\",\
          \"documentation\":\"<p>The matched events.</p>\"\
        }\
      }\
    },\
    \"Timestamp\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"Token\":{\"type\":\"string\"},\
    \"UnrecognizedClientException\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The most likely cause is an invalid AWS access key ID or secret key.</p>\",\
      \"exception\":true\
    },\
    \"UntagLogGroupRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"logGroupName\",\
        \"tags\"\
      ],\
      \"members\":{\
        \"logGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The name of the log group.</p>\"\
        },\
        \"tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>The tag keys. The corresponding tags are removed from the log group.</p>\"\
        }\
      }\
    },\
    \"Value\":{\"type\":\"string\"}\
  },\
  \"documentation\":\"<p>You can use Amazon CloudWatch Logs to monitor, store, and access your log files from Amazon EC2 instances, AWS CloudTrail, or other sources. You can then retrieve the associated log data from CloudWatch Logs using the CloudWatch console, CloudWatch Logs commands in the AWS CLI, CloudWatch Logs API, or CloudWatch Logs SDK.</p> <p>You can use CloudWatch Logs to:</p> <ul> <li> <p> <b>Monitor logs from EC2 instances in real-time</b>: You can use CloudWatch Logs to monitor applications and systems using log data. For example, CloudWatch Logs can track the number of errors that occur in your application logs and send you a notification whenever the rate of errors exceeds a threshold that you specify. CloudWatch Logs uses your log data for monitoring; so, no code changes are required. For example, you can monitor application logs for specific literal terms (such as \\\"NullReferenceException\\\") or count the number of occurrences of a literal term at a particular position in log data (such as \\\"404\\\" status codes in an Apache access log). When the term you are searching for is found, CloudWatch Logs reports the data to a CloudWatch metric that you specify.</p> </li> <li> <p> <b>Monitor AWS CloudTrail logged events</b>: You can create alarms in CloudWatch and receive notifications of particular API activity as captured by CloudTrail and use the notification to perform troubleshooting.</p> </li> <li> <p> <b>Archive log data</b>: You can use CloudWatch Logs to store your log data in highly durable storage. You can change the log retention setting so that any log events older than this setting are automatically deleted. The CloudWatch Logs agent makes it easy to quickly send both rotated and non-rotated log data off of a host and into the log service. You can then access the raw log data when you need it.</p> </li> </ul>\"\
}\
";
}

@end
