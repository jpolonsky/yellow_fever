# Yellow Fever outbreak, DRC
# Mission report on epidemiology, surveillance & data management
*Jonathan Polonsky, Epidemiologist, WHO Emergencies Programme*

## Background
On 22 March 2016, DRC reported the diagnosis of Yellow Fever (YF) cases in connection with Angola. As of 15 September, 76 cases have been officially notified (including 13 autochthonous cases) in relation to the current outbreak, in four provinces: Kinshasa, Kongo Central, Kwango, and Lualaba. A reactive mass vaccination campaign was launched in the middle of August and is currently ongoing throughout affected areas.

In addition, there is an ongoing cholera outbreak in Kinshasa and along the border with Congo-Brazzaville, and for which there will be a reactive mass vaccination campaign in the coming weeks.

## Overview
The overall situation during this two week mission was one in which there had been a decline in the rate of reported suspected YF cases, a large proportion of cases previously classified as confirmed had been reclassified as 'non-cas vaccinale' (i.e. were IgM +ive due to recent vaccination), and mass reactive vaccination campaign (MVC) had begun a day earlier. 

Owing to the demands of a mass Most YF staff were deeply involved in the vaccination campaign, with a small number dedicated to working on surveillance




However, important questions remain as to the reliability of this interpretation of the situation, particularly in view of potential weaknesses and lack of sensitivity of the surveillance system.

An overview of important issues to be explored:

- Information flow & sharing
- meetings timetable (Annex?)
- lack of field staff and supervision/overview of field realities

- requests approved but not implemented
  + DB decentralisation plan
  + field operational support


## Analysis of key indicators
> insert R analyses here....


## Data collection and management
### Description of the process

- CLEARLY DESCRIBE IN DETAIL WHAT IS HAPPENING SO NEW PEOPLE DO NOT NEED TO ASK SAME QUESTIONS

add diagram of data flow

One issue that has the potential to create confusion and duplication of efforts is the use of multiple databases for different elements of the data flow. The overall process is currently as follows: 

#### EpiInfo database

- when a suspected case is detected, a 'fiche de notification' is completed. N.B. This generic form was revised mid-outbreak to a more detailed and YF specific 'fiche d'investigation'.
- This form is sent to the Institut National de Recherche Biomédicale (INRB) (or MobileLab in Kahemba, a specialist lab deployed through the Global Outbreak Alert and Response Network (GOARN)), togther with any lab samples taken. A copy of this form is made and provided to WHO.
- INRB enter certain elements of this form into their database, while WHO enter the entire form into an EpiInfo database maintained at the WHO country office (WCO).
- Once lab results (ELIZA > PCR > PRNT) are ready, they are communicated via excel sheet to the case classification committee (CCC), chaired by the Direction de lutte contre la maladie (DLM) and including WHO, CDC and MSF, with occasional INRB participation. Simultaneously, any positive results are communicated to relevant health authorities, who conduct further investigations into the case with follow-up in-depth interviews.
- With the lab results and the results of the in-depth follow-up interviews, the CCC discusses each lab test +ive case, making a final classification based on all available information. This information is recorded directly in an excel sheet (which is itself an earlier version of the results recorded in an excel sheet circulated by the lab, to which is added newly lab +ive results by copy-paste).
- This updated excel sheet is circulated by the CCC, a copy of which is sent to WCO for updating the EpiInfo DB. Once this has been updated, a copy is shared with the DLM.

#### IDSR database

- in a somewhat seperate process, an Integrated Disease Surveillance and Response (IDSR) database is maintained using routine surveillance data.
- All suspected cases of any notifiable disease under IDSR are reported to the respective medecin chef du zone by each Aire de santé on a weekly basis.
- These are aggregated to the zone de sante level, which are then reported to the IDSR system, which are entered and stored in an Access DB.
- Each Thursday, the DLM hosts a meeting to discuss these data. For this meeting, DLM prepare a handout showing the number of suspected cases of each disease by zone de sante for the previous 3 weeks. 
- A copy of this DB is shared with WHO every week.

##### Concerns and opportunities for improvement
- Merging changes made in CCC excel sheet with lab excel sheet - both have changes that should be reflected in the other
- Collect information from all suspected cases at the time of notification - the process of seeking out patients who subsequently test positive for supplemental information (essesntially just travel and vaccination history) is long and wasteful, especially as we already have access to patients at time of speciman collection
  + One step in this process would be to rapidly phase out the use of the generic 'fiche de notification', to be replaced in all sites by the more specific YF CI form (this has been done in some but not all affected locations). This form contains much (all?) of the information collected during the subsequent deep follow-up investigation.
- The concurrent use of multiple databases for different stages in the data flow is sub-optimal. A better system would be to integrate and consolidate the data in a standardised manner, and ideally reducing the need for multiple systems.
- As with many settings, the flow of information between WCO, RO and HQ is unclear, with the default being to share from WCO to RO, and from there to HQ following verification. However, it would be much better for the rapid sharing of essential information to all concerned actors to verify the data in-country before sharing simultaneously with RO and HQ to avoid unneccessary delays. An alternative, less desirable, approach would be to remove entirely the responsibility for production of information products from HQ. But what is clear is that HQ cannot produce timely sitreps and other information products, and be in a position to repsond to external enquiries, unless they are in posession of timely, accurate data. To this end, standard operating procedures for data sharing should be agreed upon, codified, and implemented. Ideally these would broadly cover the work of the Emergency Programme, to avoid this issue arising in all future emergencies, as is the current situation.
- WHO should continue to ensure their presence at the various weekly meetings where surveillance and laboratory issues are discussed (CCC, IDSR, and YF coordination meetings). Information from these meetings needs to be clearly and systematically communicated to the data management team (for updating database with lab results and case classifications), a process which does not always occur.
- The overall organisation of CCC meeting is sub-optimal. The process of identifying newly lab-classified samples and copy-pasting these into the CCC 'master' database involves a number of steps, each of which can be prone to introducing delays and even error - sorting by lab ID, filtering by lab result, etc. In addition, the way in which newly classified cases are subsequently communicated to WHO involves highlighting cells in different colours, each signifying something. A better system would involve a centralised database which can be accessed and updated by relevant parties, and failing this, at least some form of version control, with merging the new updates from the lab with the master DB, and subsequently merging these back with the lab database.
- show simplified data flows in ppt slide! with bottlenecks...
- Decentralisation plan - approved but no funds allocated and no response
- non-unique epiid due to generation in field
- backlog of forms to be entered
- difficulty to reconcile changes in CCC master dataset w/ lab


## Surveillance & laboratory
### Case detection

- Apart from MobileLab, all samples are sent to Kinshasa INRB - show delay distributions
- concerns regarding field realities
- lack of adequate training of sample takers
- logistic support
  - phones, credit, fuel, vehicles, mobile/internet coverage...
  - transport of samples
  - lab supplies? diagnostic kits, equipment
  - training
      + what is CD. How to use it
      + How to fill forms
      + How to collect and transport samples
- Involvement of HC? should HC be involved, given new way of working in WEP? In any case, a weekly forum similar to HC IMWG should be created to share info and issues and find solutions to surveillance and lab
- HC meeting every Thursday 10am
- Proposal made to support surveillance activities in Panzi, but no response. After 1 week, MCZ Panzi came by motorbike (7 hours) on Thursday 25th August to inform that there are 28 suspected cases, and needed sample kits. He left with 50 and will return on Monday 29th.
- need field epis to observe and support/strengthen, also for voice - stefan ignored as log
- ACTIVE SURVEILLANCE instead of Passive...
- Surveillance systems:
  - IDSR - passive surveillance system. Aggregated data at ZdS level. Mostly (entirely?) suspected cases - not sure role of diagnostic tests in this, if any. Maintained by MoH and shared w/ WCO
  - YF EpiInfo - maintained by WCO, and shared with MoH
  - Lab line list
- feedback loop to field? Labs have requested this, but also to field and patients...
- what is discussed at CC meeting
    + newly lab +ive - they have case investigation done once lab +ive
    + this is really a narrative free text report, not following anything too structured
- Manifestations postvaccinales indésirables (MAPI) are not well defined
- What is being done with case investigation of probable cases (e.g. deaths?)
- Case definition - surveillance vs. outbreak... Is outbreak CD being implemented adequately, if not we are missing ~80% cases
    + CD still not settled upon
- What is alert capture system? Do we have an ability to investigate alerts?




## Vaccination campaign
- need an assessment of this as many people missed due to method
    + target was 97%, and this is what has been reported
- need case definition for MAPI

### Quotes from Stefan

>"*For the last two weeks I'm kind of representing WHO in Kahemba and participating in the surveillance meetings. These meetings are not giving us any real picture of what is the actual situation on ground as there is no active case finding ongoing nor is there communication with the different health facilities due to non existence of mobile network and huge distances between the health facilities.* 
>*We have already around 400 sample kits in Kahemba, but due to lack of means  they do not get to the places where they should be. What kind of support can we give MOH? We might be also looking at training for nurses as these types of sample tubes have not been used in this area.> I requested a list of all the health facilities and in the 5 health> zones including the availability of communication materials.* 
>*If we want to mobile lab to be of any use, we need to dramatically strengthen the surveillance component of the yellow fever epidemic response.*"

> "*The current "surveillance" activities are vey passive. On top of that we do not have regular communication with most of the health  zones.* 
> *According to the surveillance committee "No communication" with a health facility meant NO suspected case, and was recorded as such. I advised them that it should be recorded as '-'* "

> "*During yesterday's surveillance meeting MCZ again stressed the need for support to enhance surveillance in the different health zones with the priority of Panzi.* 
> *Can you let me know what would be the best way forward and when we can expect your answer regarding the proposal I forwarded last week*"

> "*Kindly find attached incident report from lab team regarding the quality of lab samples received yesterday evening.* 
> *It shows the importance of:*

> 1.  having the correct sample kits distributed to the health facilities,
> 1.  a specific training to be conducted on how to use these sample kits including the safety aspect of manipulating and transporting urine or blood samples.

> *Both are justification to the proposal sent earlier for sample kit distributed, for which we are still awaiting your approval. In any case we need to ensure healthcare workers are protected.*

> *Today's suspected case turned out not to be a suspected case at all, so health care workers might benefit from additional training in terms of case definition.*

> *Unfortunately, I do not have sufficient private funds left to be able to send a WHO vehicle with the MCZ. I never received any operational funds. From my arrival I have been funding this project with my private funds. From purchasing fuel for the vehicles to move for the supervision during the vaccination campaign to buying the fuel for the generators for PEV cold room. Now I'm still using my money to buy fuel for the running of the hospital generator to ensure a 24h power supply for the EMLAB. We only have 80 liters of fuel left for the generator to ensure the power to the lab, in combination with the solar/battery system this gives the lab another 7 days of power.*"


## Recommendations
- IM and DM/Epi should have closer collaboration
- Field epis + logs to support surveillance
- Stronger coordination required - overall surveillance, lab, epi
- Better system - exists in Angola - forms entered by WHO in morning, then DB passed to lab who enter results, which is then shared back with WHO
- Eventual plan should be for proper decentralised and disaggregated surveillance system (e.g EWARS), with single, centralised database (one source of truth from which everyone works, incl. MoH, WCO, RO and HQ)
    + plan for decentralisation only to provincial level
    + current IDSR is aggregated only
- training for staff
- reinforce surveillance on road to, and within, Kikwit
- Evaluate the sensitivity of the surveillance system (e.g. Rapid capture-recapture study)
- Somebody should bring epiinfo DB master to CC meeting and work done directly on that DB
    + or code written to compare last version of lab with what was just sent to identify those with changes


## Annexes
- Terms of reference
- Epidemiological context & analysis of current situation
- Case definition
- 2 decision trees
- Elements of Anita and Philippe's reports
- Meetings timetable?

