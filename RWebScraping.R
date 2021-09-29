install.packages('rvest')
install.packages('stringr')
install.packages('robotstxt')
install.packages('xml2')
install.packages('magrittr')
install.packages('bs4')
install.packages('requests')
install.packages('stargazer')
install.packages('gt')
install.packages('glue')


library(rvest)
library(stringr)
library(robotstxt)
library(xml2)
library(magrittr)
library(bs4)
library(requests)
library(stargazer)
library(gt)
library(glue)

url <- 
  'http://books.toscrape.com/catalogue/category/books/historical-fiction_4/index.html'
get_robotstxt(url)

web_code <- read_html(url)

titles <- read_html(url) %>%
  html_nodes('.product_pod a') %>%
  html_text()
print(titles)

frame_titles <- data.frame(titles)

clean_titles <- frame_titles[!apply(frame_titles == "", 1, all),]
print(clean_titles)

prices <- read_html(url) %>%
  html_nodes('.price_color') %>%
  html_text()
print(prices)

availability <- read_html(url) %>%
  html_nodes('.availability') %>%
  html_text(trim=TRUE)
print(availability)

thumbnails <- read_html(url) %>%
  html_nodes('.thumbnail') %>%
  html_attr('src') %>%
  str_replace_all('./../../../', '/')
print(thumbnails)

scraped_data <- data.frame(
  Title = clean_titles,
  Price = prices,
  Availablility = availability,
  Image = thumbnails
  
)

print(scraped_data)

clean <- scraped_data[!apply(scraped_data == "     ", 1, all),]

book_log <- gt(clean)

print(book_log)    

  


