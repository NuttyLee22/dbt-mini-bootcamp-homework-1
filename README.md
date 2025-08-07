# 🎃 Horrorland dbt Workshop

[![Powered by DataGym.io](https://img.shields.io/badge/Powered%20by-DataGym.io-%23005FFF?style=for-the-badge\&logo=data\&logoColor=white)](https://www.datagym.io)

> 🚨 **IMPORTANT NOTICE – BOOTCAMP TEMPLATE**
> This repository is used **exclusively for the DataGym.io dbt mini bootcamp**.
>
> ✅ To work on your project:
>
> 1. **Clone this repository**
>
>    ```bash
>    git clone https://github.com/datagym-io/2025-08-dbt-mini-bootcamp.git
>    ```
>    ```bash
>    cd 2025-08-dbt-mini-bootcamp
>    ```
> 2. **Create your own branch** (replace `<your_name>`):
>
>    ```bash
>    git checkout -b <your_name>
>    ```
> 3. Work only inside your branch.
> 4. **❌ Do NOT open PRs or merge anything into the `main` branch.**


---

## 📚 Table of Contents

* [👻 Context](#-context)
* [❄️ Getting Started with Snowflake](#️-getting-started-with-snowflake)
* [⚙️ Setting Up dbt Fusion](#️-setting-up-dbt-fusion)
* [🛠️ Initializing Your Project](#️initializing-your-project)
* [🧹 Clean Up Default Folders](#️clean-up-default-folders)
* [💡 What You’ll Learn](#-what-youll-learn)
* [💬 Support & Questions](#-support--questions)

---

## 👻 Context

You work at **Horrorland**, a spooky and thrilling theme park.

The Halloween season is near, but something is wrong:

* Visitors are unhappy
* VIPs may not be getting their money’s worth
* Ticket pricing feels off
* Fear levels may or may not influence ratings

You’ve been tasked with answering:

1. What are the top selling products?
2. How do daily wait times correlate with customer satisfaction scores?
3. What are our most expensive costs?
4. What are the most common types of incidents per haunted house?
5. And more


---

## ❄️ Getting Started with Snowflake

### Step 1: Create a Snowflake Trial Account

1. Go to [signup.snowflake.com](https://signup.snowflake.com/?trial=student)
2. Choose:

   * **Enterprise Edition**
   * **AWS** as the cloud provider
3. Set up a **username** and **password**
4. Save your **Account Identifier**

### How to find your Account Identifier:

1. Open the **Snowflake Web UI**
2. Click your **user avatar** (bottom-left)
3. Go to **Account > View Account Details**
<img src="./images/account_id_1.png" alt="Account Identifier" width="400"/>
4. Copy the `Account Identifier`, e.g.:
   `RVDLYID-LX74876`
<img src="./images/account_id_2.png" alt="Account Identifier" width="400"/>

---

### Step 2: Ingest Raw Data

We'll simulate data ingestion using SQL scripts.

1. In the Snowflake UI, click **Projects** > **Worksheets** > **+**
<img src="./images/ingest_1.png" alt="Account Identifier" width="400"/>

2. If prompted, use the role **ACCOUNTADMIN** and the warehouse **COMPUTE_WH**
<img src="./images/ingest_2.png" alt="Account Identifier" width="400"/>

3. Copy the contents of [snowflake_insert.txt](./snowflake_insert.txt)
4. Paste into the worksheet, select everything, and **run** it
<img src="./images/ingest_3.png" alt="Account Identifier" width="400"/>
This will create your raw tables.


---

## ⚙️ Setting Up dbt Fusion

We’ll use **dbt Fusion**, the new Rust-powered dbt engine. dbt Fusion is still in beta, so sometimes we might use dbt Core. If you use Windows, read below.

### ✅ Option 1 (Recommended - Only supported on MacOS/Linux): Install via VS Code Extension

Search for `dbtLabsInc.dbt` in the Extensions tab or use these links:

* [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=dbtLabsInc.dbt)
* [Cursor Marketplace](https://marketplace.cursorapi.com/items?itemName=dbtLabsInc.dbt)

It installs dbt Fusion automatically.


<img src="./images/extension.png" alt="Account Identifier" width="400"/>


It will ask you to register the extension within 14 days. You can register for free.

---

### 💻 Option 2: Install via CLI (Only supported on MacOS/Linux)

#### macOS / Linux

```bash
curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update
```
```bash
exec $SHELL
```

---

### 🐧 Option 3: WSL (Recommended for Windows)
> [!WARNING]
> Native dbt Fusion installation on Windows is not officially supported, so the work around is to install the dbt Fusion using WSL and VS Code.


##### 1. Installing WSL on Windows
First thing to install the dbt-Fusion on Windows, you need to install the WSL in your Windows, for this you can use the [Official Microsoft tutorial](https://learn.microsoft.com/en-us/windows/wsl/install)


##### 2. Installing WSL Extensions on VS Code
After the WSL, Install two Extensions in VS Code: “WSL” and “Remote Explorer”, this is pretty straight foward, but if you have doubts, you can check the [Official VS Code Tutorial](https://code.visualstudio.com/docs/remote/wsl)

<img src="./images/remote_explorer_wsl.png" alt="Remote Explorer" width="400"/>

After this two steps, we are able to install the dbt-Fusion

##### 3. Initialize the WSL on VS Code
Click on the “Open a Remote Window” button on the bottom left corner of VS Code (Blue icon)

<img src="./images/open_remote_window.png" alt="Open Remote Window" width="300"/>

##### 4. Connect to WSL on VS Code
Click on “Connect to WSL”, it will prompt you to install a version of Linux if you don't have one. You can choose any version, I'm using Ubuntu.

<img src="./images/connect_to_wsl.png" alt="Connect to WSL" width="600"/>

Wait till your WSL kicks up, then proceed to the next step.

<img src="./images/connecting_to_wsl.png" alt="Connecting to WSL" width="400"/>

Check if the WSL is running in the bottom left corner of VS Code

<img src="./images/check_wsl_connected.png" alt="Check WSL connected" width="300"/>

##### 5. Installing the dbt Extension on VS Code
Navigate to the Extensions menu on the left and search for “dbt”, it should be the first extension to appear and install it.

<img src="./images/install_dbt_extension.png" alt="Installing dbt Extension" width="700"/>

##### 6. Installing the dbt Fusion
And last but not least, installing the dbt fusion, you will need a terminal on VS Code and WSL activated for this step.
You can open one in Terminal > New Terminal

You just need to run the following command (copy and right click into the terminal): 

```bash
curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update
```

If you have any doubt, you can follow the instructions as you were installing dbt Fusion on Linux with this [Official dbt Tutorial](https://docs.getdbt.com/docs/fusion/install-fusion)

<img src="./images/running_dbt_install_command.png" alt="Running dbt Fusion" width="600"/>


##### 7. Check the install of dbt Fusion
To test if it the installation worked, you need to kill the terminal, open a new one and type the command

```bash
dbtf --version
```

It should appear a message with the current version.


<img src="./images/testing_dbtf.png" alt="Testing dbt Fusion" width="400"/>


#### Note: you ALWAYS need to initialize the WSL before starting or working on a dbt Fusion project, otherwise it wont work.

---

### 🐍 Option 4:  Windows Fallback: Use dbt Core (Legacy CLI)

If you can’t install dbt Fusion on Windows, you can fall back to the classic dbt Core CLI:

##### 1. Create a virtual environment

**On Windows CMD or PowerShell:**

```powershell
python -m venv venv
```
```powershell
.\venv\Scripts\activate
```

##### 2. Install dbt for Snowflake

```bash
pip install dbt-snowflake
```

##### 3. Verify Installation

```bash
dbt --version
```


---

## 🛠️ Initializing Your Project

Use `dbtf init` to create your dbt project from scratch.

```bash
dbtf init --project-name horrorland
```

You will be prompted to fill:

| Prompt      | Recommended Value                    |
| ----------- | ------------------------------------ |
| Adapter     | `snowflake`                          |
| Account     | Your Account Identifier (e.g., RVDLYID-LX74876)              |
| User        | Your Snowflake Username  (e.g., bruno)             |
| Auth Method | `password`                           |
| Password    | Your Snowflake Password              |
| MFA         | `N` (not required for workshop)      |
| Role        | `ACCOUNTADMIN` *(for workshop only)* |
| Database    | `DEV_DATABASE` *(created in the ingestion step)*     |
| Warehouse   | `COMPUTE_WH`                         |
| Schema      | The name you want (e.g. `BRUNO`)             |

You should see a confirmation like:

<img src="./images/connection.png" alt="Account Identifier" width="400"/>

> [!WARNING]
> If you face an error in Windows that says the `profiles.yml` was not found
> Probably it was created within a .dbt folder in your project.
> Move the profiles.yml out from this folder into the root folder of your project `horrorland/profiles.yml`.
> This should fix the issue.

---

## 🧹 Clean Up Default Folders

MacOS/Linux
```bash
cd horrorland
```
```bash
rm -rf seeds macros target
```
```bash
rm -rf models/*
```

Windows (PowerShell)
```bash
cd horrorland
```
```bash
Remove-Item -Recurse -Force .\seeds, .\macros, .\target
```
```bash
Remove-Item -Recurse -Force .\models\*
```

## 🔄 Reload window

For the extension to work properly, your VSCode/Cursor workspace must be the root folder of the dbt_project, in this case `/horrorland`.

Make sure you are within the `/horrorland` folder in your terminal, and run

```bash
code . #if VSCode
```
```bash
cursor . #if Cursor
```
> If `code .` or `cursor .` doesn't work, open VS Code or Cursor manually and choose **File > Open Folder...**, then select the `horrorland` folder.


Now you're ready to start modeling!

---

## 💡 What You’ll Learn

- ✔️ Connect dbt Fusion to Snowflake
- ✔️ Ingest and clean raw data
- ✔️ Build a star schema
- ✔️ Add freshness and data quality tests
- ✔️ Use `sources`, `staging`, `marts`
- ✔️ Apply unit tests and documentation
- ✔️ Explore dbt lineage and insights

---

## 💬 Support & Questions

Use the appropriate Discord channels:

* `❓-duvidas-🇧🇷` — Portuguese Q\&A
* `❓-questions-🇺🇸` — English Q\&A
* `support-suporte-🌎` — General help

Or visit [DataGym.io](https://www.datagym.io)

---

👻 Good luck, and may your data models never haunt you!
