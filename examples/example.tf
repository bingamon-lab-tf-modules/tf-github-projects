terraform {
  required_version = ">= 1.9.0"
}

module "tf-github-projects" {
  source = "github.com/bingamon-lab-tf-modules/tf-github-projects?ref=v1.0.0"
  #version = "~> 1.0"

  # TFVars go here

}
