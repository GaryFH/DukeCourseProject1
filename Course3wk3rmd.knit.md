---
title: "Course3Week3RMD"
author: "GaryFH"
date: "May 15, 2018"
output: html_document

#title: "Multiple linear regression"
#output: statsr:::statswithr_lab

references:
- id: Hamermesh2005
  title: Beauty in the Classroom - Instructors' Pulchritude and Putative Pedagogical Productivity
  author:
  - family: Hamermesh
    given: Daniel S.
  - family: Parker
    given: Amy
  volume: 24
  URL: 'http://www.sciencedirect.com/science/article/pii/S0272775704001165'
  DOI: 10.1016/j.econedurev.2004.07.013
  publisher: Economics of Education Review
  ISSN: 0272-7757
  issue: 4
  page: 369-376
  type: article-journal
  issued:
    year: 2005
    month: 8
- id: Gelman2007
  title: Data Analysis Using Regression and Multilevel/Hierarchical Models
  author:
  - family: Gelman
    given: Andrew
  - family: Hill
    given: Jennifer
  publisher: Cambridge University Press
  city:
  type: book
  issued:
    year: 2007
  edition: 1
  ISBN: 9780521686891
---

<div id="instructions">
Complete all **Exercises**, and submit answers to **Questions** on the Coursera 
platform.
</div>

## Grading the professor

Many college courses conclude by giving students the opportunity to evaluate 
the course and the instructor anonymously. However, the use of these student 
evaluations as an indicator of course quality and teaching effectiveness is 
often criticized because these measures may reflect the influence of 
non-teaching related characteristics, such as the physical appearance of the 
instructor. The article titled, "Beauty in the classroom: instructors' 
pulchritude and putative pedagogical productivity" [@Hamermesh2005] 
found that instructors who are viewed to be better looking receive higher 
instructional ratings. 

In this lab we will analyze the data from this study in order to learn what goes 
into a positive professor evaluation.

## Getting Started

### Load packages

In this lab we will explore the data using the `dplyr` package and visualize it 
using the `ggplot2` package for data visualization. The data can be found in the
companion package for this course, `statsr`.

Let's load the packages.

















































