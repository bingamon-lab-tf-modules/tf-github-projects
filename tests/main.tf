module "test" {
  source = "../module"

  github_enterprise_slug   = "acme-corp"
  github_organization_name = "acme-engineering"

  github_managed_repositories = [
    "acme-engineering/acme-service"
  ]

  github_projects = [
    {
      name       = "acme-engineering/acme-service-1"
      type       = "repository"
      repository = "acme-engineering/acme-service"
      body       = "This is a test project"
      columns = [
        {
          name = "To Do"
        },
        {
          name = "In Progress"
        },
        {
          name = "Done"
        }
      ]
    },
    {
      name = "acme-engineering/acme-service-2"
      type = "organization"
      body = "This is a test project"
      columns = [
        {
          name = "To Do"
        },
        {
          name = "In Progress"
        },
        {
          name = "Done"
        }
      ]
    }
  ]

}
