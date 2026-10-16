resource "google_service_account" "node_sa" {
    for_each = var.service_accounts

    project      = var.project_id
    account_id   = each.value.account_id
    display_name = each.value.display_name
    description  = each.value.description
}

resource "google_project_iam_member" "service_account_roles" {
    for_each = var.project_role_bindings

    project = var.project_id
    role = each.value.role
    member = "serviceAccount:${google_service_account.node_sa[each.value.service_account_key].email}"
}