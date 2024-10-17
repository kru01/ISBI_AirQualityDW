<a name="readme-top"></a>

# ISBI - Data Warehouse with EPA's Air Quality Data

-   Group project from HCMUS's 2024 Information Systems for Business Intelligence course.

-   Datasource: Refer to **Sect. 3.1** in the [Assignment](./Docs/[BI-2425]Project%20Assignment.docx.pdf).

## Getting Started

### Prerequisites

-   Windows 11.
-   SQL Server [2019](https://go.microsoft.com/fwlink/?linkid=866662) or [2022](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) Developer and [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16).
    -   In the `SQL Server Setup` wizard's `Feature Selection`, make sure to install both [Analysis Services](https://learn.microsoft.com/en-us/analysis-services/instances/install-windows/install-analysis-services?view=asallproducts-allversions) and [Integration Services](https://learn.microsoft.com/vi-vn/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver16).
    -   If you miss the wizard during initial installation, it can be accessed through searching for `SQL Server 20xx Installation Center` in the Windows' `Start menu`.
        -   [SQL Server SSIS Install with Billy Thomas ALLJOY Data](https://youtu.be/EvUDqyXD9NI?si=aCm41iII1QAx9w9X&t=59).
-   [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) and its `Data storage and processing` workload.
    -   [Integration Services Projects](https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices) and [Analysis Services Projects](https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects2022).
    -   Alternatively, consider [VS2019](https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2019&source=VSLandingPage&cid=2030:8fba1c3637a1496ca222c98e05acdc19), and its corresponding workload and extensions, for access to [Data Mining](https://learn.microsoft.com/en-us/analysis-services/data-mining/data-mining-wizard-analysis-services-data-mining?view=asallproducts-allversions).

### Installation

1. Clone the repo.

    ```console
    https://github.com/kru01/ISBI_AirQualityDW.git
    ```

1. Run scripts in the [SQL](./SQL/) folder in the following order to set up the Data Warehouse.

    ```txt
    create_metadata -> create_stage
    ```

## Meet The Team

<div align="center">
  <a href="https://github.com/phongan1x5"><img alt="phongan1x5" src="https://github.com/phongan1x5.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/kru01"><img alt="kru01" src="https://github.com/kru01.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/faithdanghuy"><img alt="faithdanghuy" src="https://github.com/faithdanghuy.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/uyeexnnhi"><img alt="uyeexnnhi" src="https://github.com/uyeexnnhi.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>
