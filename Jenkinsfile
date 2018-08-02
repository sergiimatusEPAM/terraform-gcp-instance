#!/usr/bin/env groovy
# WIP Jenkinsfile
# Security CI Library Referenced
# Remove the verify author stage and library call out if not needed
 @Library('sec_ci_libs') _

 def master_branches = ["master", ] as String[]

 ansiColor('xterm') {
  node('terraform') {
    stage("Verify author") {
      user_is_authorized(master_branches, '8b793652-f26a-422f-a9ba-0d1e47eb9d89', '#tools-infra')
    }

     stage("a hello world") {
      checkout scm
      sh 'terraform fmt -diff -check -write'
      sh 'terraform init'
      sh 'terraform validate -check-variables=false'
    }
  }
}
