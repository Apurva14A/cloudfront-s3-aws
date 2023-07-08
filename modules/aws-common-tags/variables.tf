# AWS common tags configure

variable "common_tags" {
    description = "AWS Common tags for the resources"
    type = map(string)
    default = {
        account = " "
        application = " "
        business = " "
        function = " "
        environment = " "

    }
}

