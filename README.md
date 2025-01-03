<a name="readme-top"></a>

# ISBI - Data Warehouse with EPA's Air Quality Data

-   Group project from HCMUS's 2024 Information Systems for Business Intelligence course.

-   Our [demo playlist](https://youtube.com/playlist?list=PLnfnJ5OTnHtOGSF_7IGO4POBs6xLR9M6w&si=PDYsodbme1MaR0Ba).

-   Datasource: Refer to **Sect. 3.1** in the [Assignment](./Docs/[BI-2425]Project%20Assignment.docx.pdf).

## Getting Started

### Prerequisites

Regarding our setup,

-   `SQL Server 2019` and `SSMS 19`.
-   `Visual Studio 2022` for SSIS, and `VS2019` for SSAS and Data Mining.
-   For all server connections, we just use a `.` (i.e., `localhost`) and Windows authentication.

---

-   Windows 11.
-   SQL Server Developer [2019](https://go.microsoft.com/fwlink/?linkid=866662) or [2022](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) and [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16).
    -   In the `SQL Server Setup` wizard's `Feature Selection`, make sure to install both [Analysis Services](https://learn.microsoft.com/en-us/analysis-services/instances/install-windows/install-analysis-services?view=asallproducts-allversions) and [Integration Services](https://learn.microsoft.com/vi-vn/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver16).
    -   If you miss the wizard during initial installation, it can be accessed through searching for `SQL Server 20xx Installation Center` in the Windows' `Start menu`.
        -   [SQL Server SSIS Install with Billy Thomas ALLJOY Data](https://youtu.be/EvUDqyXD9NI?si=aCm41iII1QAx9w9X&t=59).
-   [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) and its `Data storage and processing` workload.
    -   [Integration Services Projects](https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices) and [Analysis Services Projects](https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects2022).
    -   Alternatively, consider [VS2019](https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2019&source=VSLandingPage&cid=2030:8fba1c3637a1496ca222c98e05acdc19), and its corresponding workload and extensions, for access to [Data Mining](https://learn.microsoft.com/en-us/analysis-services/data-mining/data-mining-wizard-analysis-services-data-mining?view=asallproducts-allversions).
-   [Power BI Desktop](https://apps.microsoft.com/detail/9ntxr16hnw1t?hl=en-US&gl=US).

### Installation

1. Clone the repo.

    ```console
    https://github.com/kru01/ISBI_AirQualityDW.git
    ```

1. Run scripts in the [SQL](./SQL/) folder in the following order to set up the Data Warehouse.

    ```txt
    1_create_metadata -> 2_create_stage -> 4_create_nds -> 5_create_dds
    ```

    1. `3_clean_data.sql` **MUST** only be run after **completing ETL from Source to Stage**.

    1. `6_create_mining.sql` is for SSAS's Data Mining, **MUST** only be run after **the whole data warehouse is completed**.

1. For `SSIS`, if your server is not on `localhost`, better change all the packages' `Connection Managers`. Otherwise,

    1. In `CsvSrc_Stage`, edit the `10_STATE_AQI - LOOP CSVs` and change the `Folder` path in the `Collection` tab.
    1. Also in the same package, reselect the flat file connection `2b_uscounties_csv`'s `File name`.

1. For `SSAS`, double-click `21BI11 DDS.ds` in the `Solution Explorer`, navigate to the `Impersonation Information` tab then change the Windows `User name` and `Password`.

    1. Be aware that this is the password associated with your **Microsoft account** (or the personal `Outlook` mail in our case), _not whatever PIN or password for the Windows Lock Screen._

1. For `Power BI`, ensure that the cube has been properly processed and deployed to SSAS, and if the server is not on base `localhost`, may need to alter the `Data Source`. Enable the following `Options`,

    1. `Security` &#8594; `Use Map and Filled Map visuals`.
    1. `Preview features` &#8594; `Shape map visual`.

## Usage

All processes and possible usages of our work are detailed thoroughly in the [Report](./Docs/Report.pdf), so give it a read for starters, or go through our [demo playlist](#isbi---data-warehouse-with-epas-air-quality-data), _or just poke around since the project is pretty straightforward_.

## Meet The Team

<div align="center">
  <a href="https://github.com/phongan1x5"><img alt="phongan1x5" src="https://github.com/phongan1x5.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/kru01"><img alt="kru01" src="https://github.com/kru01.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/faithdanghuy"><img alt="faithdanghuy" src="https://github.com/faithdanghuy.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/uyeexnnhi"><img alt="uyeexnnhi" src="https://github.com/uyeexnnhi.png" width="60px" height="auto"></a>&nbsp;&nbsp;&nbsp;
</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>
