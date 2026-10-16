output "service_account_emails" {
    description = "email addresses of created service accounts."

    value = {
        for key, account in google_service_account.node_sa :
        key => account.email
    }
}

output "service_account_ids" {
    description = "Unique ids of the created service account."

    value = {
        for key, account in google_service_account.node_sa :
        key => account.unique_id
    }
}