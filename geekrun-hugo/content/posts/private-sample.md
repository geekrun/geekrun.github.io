---
title: "Sample Private Post"
date: 2024-08-06
draft: false
description: "A sample post demonstrating the encryption feature"
tags: ["private", "sample", "encryption"]
categories: ["private"]
toc: true
readingTime: true
---

# Sample Private Post

This is a sample post that demonstrates the encryption feature of the blog. Some content below is password protected.

## Public Content

This content is visible to everyone. You can write normal blog posts with regular content here.

### Code Example

Here's a sample code block:

```python
def hello_world():
    print("Hello, World!")
    return "Success!"

# Call the function
result = hello_world()
print(result)
```

## Protected Content

The following content is password protected. The password is `secret123`.

{{< encrypt "secret123" >}}

### Secret Information

This is the encrypted content that only appears after entering the correct password.

#### Sensitive Data

- **API Keys**: `sk-1234567890abcdef`
- **Database URL**: `postgresql://user:pass@localhost:5432/db`
- **Admin Password**: `super_secret_admin_password`

#### Private Notes

These are my private notes that I don't want to share publicly:

1. **Project Ideas**:
   - Build a personal finance tracker
   - Create a recipe management app
   - Develop a habit tracking system

2. **Learning Goals**:
   - Master Rust programming
   - Learn Kubernetes deployment
   - Study machine learning algorithms

3. **Personal Goals**:
   - Exercise 3 times per week
   - Read 2 books per month
   - Practice meditation daily

#### Secret Code

```javascript
// This is my secret algorithm
function secretAlgorithm(input) {
    const key = "my-super-secret-key";
    const encrypted = encrypt(input, key);
    return base64Encode(encrypted);
}

// Usage
const result = secretAlgorithm("sensitive data");
console.log(result);
```

{{< /encrypt >}}

## More Public Content

You can continue with regular content after the encrypted section. This demonstrates how you can mix public and private content in the same post.

### Benefits of This Approach

1. **Flexibility**: Mix public and private content in the same post
2. **Security**: Client-side encryption keeps sensitive data safe
3. **User Experience**: Smooth password entry with visual feedback
4. **SEO Friendly**: Public content is still indexed by search engines

---

*This post demonstrates the encryption feature. In real usage, you would replace the sample password with a more secure one.* 