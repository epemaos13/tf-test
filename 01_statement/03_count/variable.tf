variable "user_names" {
    description = "Create IAM users with these names"
    type        = list(string)
    default     = ["aws18-neo", "aws18-trinity", "aws18-morpheus"]
}