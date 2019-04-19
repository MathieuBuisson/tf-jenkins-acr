output "eventhub_producer_connection_string" {
  value = "${module.producer-access-policy.connection_string}"
}

output "eventhub_consumer_connection_string" {
  value = "${module.consumer-access-policy.connection_string}"
}
