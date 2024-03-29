% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/userLogoutModule.R
\name{userLogoutUI}
\alias{userLogoutUI}
\alias{userLogoutModule}
\title{Shiny module for logout menu}
\usage{
userLogoutUI(id)

userLogoutModule(input, output, session, username = "unknown")
}
\arguments{
\item{id}{Input id}

\item{username}{Use \code{\link{get_user}} to get the current user.}
}
\description{
Shiny module for logout menu
}
