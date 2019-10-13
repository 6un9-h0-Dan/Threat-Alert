

As the world shifts from private to public cloud infrastructure, the need for agile security solutions has given rise to the world of DevSecOps.  This means thinking about application and infrastructure security from the start. It also means automating your approach to security to not block other areas of your DevOps workflow such as CI/CD. While any true DevSecOps environment starts with a cultural shift, the importance of selecting the right tools to seamlessly integrate with your environment cannot be understated. StackArmor leverages a robust portfolio of software (some homegrown, some enterprise license, some FOSS) to meet the security needs of customers across every industry: FedRAMP, PCI DSS, NIST 800-53 and HIPAA to name a few.

Here are some of the tools that StackArmor leverages to meet DevSecOps requirements and how they meet them:

### 1. Continuous Monitoring - ThreatAlert
1. Scans your all of your AWS accounts for centralized threat identification.
1. Monitors the following:
    1. Network security
    1. Personnel activity
    1. Configuration changes
    1. Detects deviations from desired states in security, fault tolerance and performance.
1. Identity ICAM vulnerabilities
1. User friendly GUI to easily browse, filter, search across findings.
1. Categorizes all non-compliant findings into individual POA&Ms with recommendations for remediation.

### 2. Container Security and Compliance - Anchore
1. Can run as a container sidecar for seamless integration with your application.
1. Performs a detailed and thorough scan for any known vulnerabilities in your application and operating system packages
1. Generates a detailed manifest of your application for easy policy application.
1. Ensures sensitive data such as passwords and API keys are not present in container images.
1. Fully analyzes Dockerfile to ensure best practices are followed.
1. Support for Security Content Automation Protocol (SCAP) and Container configuration policies
1. Integrates with Container CI/CD.
1. Compatible with Container Orchestration tools such as Docker Swarm and Kubernetes.

### 3. Security Incident and Event Management - Splunk
1. Ingests logging events for all user, network, application and data activities.
1. Aggregates and filters logs for transformation into standardized format.
1. Assists with detection of advanced persistent threats and forensics.
1. Notifies security teams of detected events.
1. Capable of automatic remediation of high priority events.
1. Improves visibility of system events to reduce downtime and improve customer experience.

### 4. Intrusion Detection and Prevention - TrendMicro
1. Inspect and block inbound, outbound, and lateral network traffic in real-time
1. Deliver scalable performance up to 100 Gbps inspection throughput with low latency
1. Drive vulnerability threat prioritization with complete network visibility
1. Provide immediate and ongoing threat protection with out-of-the-box recommended settings
1. Defends against the latest threats, including ransomware
1. Monitors traffic for new vulnerabilities with host-based intrusion prevention filters and zero-day attack monitoring

### 5. Threat Modeling and Vulnerability Assessment - Tenable Nessus
1. Identify configuration vulnerabilities across a wide spectrum of operating systems.
1. Built in support for compliance regulations, such as DISA Security Technical Implementation Guides (STIGs), NIST 800-53. 
1. Provides recommedations for immediate remediation.
1. Built-in and extensible database assessment capabilities
    1. Find the database common security vulnerabilities such as:
      1. Weak password
      1. Known configuration risks 
      1. Missing patches
      1. Structured Query Language (SQL) injection test tool
      1. Data access control test
      1. User access control test 
      1. Denial of service test
 
 ### 6. Code Vulnerability Scanning - Sonarqube
 1. Analyze a running application dynamically and can identify runtime vulnerabilities (RASP)and environment related issues.
 1. Integrates with CI/CD tools for seamless code vulnerability assessments.
 1. Interactive, Dynamic, and Static Application Security Test capabilities (IAST DAST & SAST).
 1. Offers recommended remediation for findings.
 1. Identifies static code weaknesses.




    
