terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
    }
  }
}

variable "LAUNCHDARKLY_ACCESS_TOKEN" {
  type = string
}

provider "launchdarkly" {
  access_token = var.LAUNCHDARKLY_ACCESS_TOKEN
}

resource "launchdarkly_project" "qcon" {
  key  = "ld-demo-qcon"
  name = "ld-demo-qcon"

  tags = [
    "terraform",
  ]

  environments {
        key   = "dev"
        name  = "Development"
        color = "7B42BC"
        tags  = ["terraform"]
  }
  default_client_side_availability {
    using_environment_id = true
    using_mobile_key     = false
  }
}

resource "launchdarkly_feature_flag" "qrcode" {
  project_key = launchdarkly_project.qcon.key
  key         = "qrcode"
  name        = "QR Code"
  description = "This flag enables the view of the QR Code on our application canvas for mobile device viewing"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "QR Code On"
    description = "Show the QR Code"
  }
  variations {
    value       = "false"
    name        = "QR Code Off"
    description = "Disable the QR Code for mobile device viewing "
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed"
  ]
}

resource "launchdarkly_feature_flag" "logoversion" {
  project_key = launchdarkly_project.qcon.key
  key         = "logoversion"
  name        = "Logo Version"
  description = "This flag controls which logo is visible within the application"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Show Toggle Logo"
    description = "Toggle makes their grand appearance!"
  }
  variations {
    value       = "false"
    name        = "Default LaunchDarkly Logo"
    description = "Shows the default LaunchDarkly Osmo logo"
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed",   
  ]
}

resource "launchdarkly_feature_flag" "cardshow" {
  project_key = launchdarkly_project.qcon.key
  key         = "cardshow"
  name        = "Release Cards"
  description = "This flag controls the visibility of the release cards on the bottom of the UI "

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Show Release Cards"
    description = "Show the app delivery release cards"
  }
  variations {
    value       = "false"
    name        = "Disable Card Views"
    description = "Do not show the release cards "
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed",   
  ]
}

resource "launchdarkly_feature_flag" "upperimage" {
  project_key = launchdarkly_project.qcon.key
  key         = "upperimage"
  name        = "Upper Image"
  description = "Show the upper immage on page"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Show Image"
    description = "Display the image"
  }
  variations {
    value       = "false"
    name        = "Disable Image"
    description = "Disable the image from being viewed "
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed",   
  ]
}

resource "launchdarkly_feature_flag" "login" {
  project_key = launchdarkly_project.qcon.key
  key         = "login"
  name        = "Login UI"
  description = "Show the login box for user targeting"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Login enabled"
    description = "Login box presented"
  }
  variations {
    value       = "false"
    name        = "Login Disabled"
    description = "Not able to login "
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed",   
  ]
}

resource "launchdarkly_feature_flag" "prodHeader" {
  project_key = launchdarkly_project.qcon.key
  key         = "prodHeader"
  name        = "Production Header"
  description = "Enables the production header view in the UI"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Show New Header Design"
    description = "Show the updated LaunchDarkly header"
  }
  variations {
    value       = "false"
    name        = "Show Old Header Design"
    description = "Displays header showing common app delivery "
  }
  
  defaults {
    on_variation = 1
    off_variation = 0
  }

  tags = [
    "terraform-managed",   
  ]
}

output "LaunchDarkly_API_Key" {
  value = launchdarkly_project.qcon.environments[0].api_key
  sensitive = true
}

output "LaunchDarkly_Client_Side_Key" {
  value = launchdarkly_project.qcon.environments[0].client_side_id
  sensitive = true
}
