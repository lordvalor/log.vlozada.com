---
title: lordvalor
layout: layout.njk
---

## Posts Recientes

{% for post in collections.post reversed %}
- [{{ post.data.title }}]({{ post.url }}) — {{ post.date | date: "%Y-%m-%d" }}
{% endfor %}