output "endpoint_ids" {
    description = "Resource name of created endpoint ids"

    value = {
        for key, endpoint in google_vertex_ai_endpoint.vertex_ai :
        key => endpoint.name
    }
}

output "endpoint_display_name" {
    description = "Display name of created vertex ai endpoint."

    value = {
        for key, endpoint in google_vertex_ai_endpoint.vertex_ai :
        key => endpoint.display_name
    }
}

output "endpoint_region" {
    description = "Vertex ai Endpoint region"

    value = {
        for key, endpoint in google_vertex_ai_endpoint.vertex_ai :
        key => endpoint.location
    }
}