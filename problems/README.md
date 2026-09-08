# 100 Database Challenges

The first 51 problems are traceable to the original coursework. Problems 52-100 are new advanced extensions built on the same domains.

| ID | Problem | Difficulty | Topics | Provenance |
|---|---|---|---|---|
| [P001](./001-hospital-relational-schema/) | Hospital relational schema | Easy | DDL, PK, FK | Legacy coursework: hospital database project |
| [P002](./002-nguyen-employees-in-tphcm/) | Nguyen employees in TPHCM | Easy | SELECT, LIKE, AND | Legacy coursework: hospital database project |
| [P003](./003-patients-without-a-doctor/) | Patients without a doctor | Easy | NOT EXISTS, anti-join | Legacy coursework: hospital database project |
| [P004](./004-patients-in-tphcm/) | Patients in TPHCM | Easy | WHERE | Legacy coursework: hospital database project |
| [P005](./005-adult-nguyen-employees/) | Adult Nguyen employees | Easy | date, LIKE | Legacy coursework: hospital database project |
| [P006](./006-employees-who-are-nurses/) | Employees who are nurses | Easy | EXISTS, subtype | Legacy coursework: hospital database project |
| [P007](./007-map-a-one-to-one-erd/) | Map a one-to-one ERD | Medium | ERD, 1:1 | Original: ASM_P2.py |
| [P008](./008-map-a-many-to-one-erd/) | Map a many-to-one ERD | Medium | ERD, N:1 | Original: ASM_P2.py |
| [P009](./009-map-a-many-to-many-erd/) | Map a many-to-many ERD | Medium | ERD, N:N | Original: ASM_P2.py |
| [P010](./010-map-supertype-and-subtype/) | Map supertype and subtype | Medium | ERD, inheritance | Original: ASM_P2.py |
| [P011](./011-attribute-closure/) | Attribute closure | Medium | FD, closure | Original: ASM_P2.py |
| [P012](./012-enumerate-candidate-keys/) | Enumerate candidate keys | Hard | FD, candidate key | Original: ASM_P2.py |
| [P013](./013-assignment-university-schema/) | Assignment university schema | Easy | DDL, constraints | Original: ASM.SQL |
| [P014](./014-generate-sv-code-without-identity/) | Generate SV code without IDENTITY | Hard | SEQUENCE, concurrency | Original: ASM.SQL |
| [P015](./015-add-course-result-procedure/) | Add course result procedure | Easy | procedure | Original: ASM.SQL |
| [P016](./016-validate-score-domain/) | Validate score domain | Medium | CHECK, trigger | Original: ASM.SQL |
| [P017](./017-list-all-students/) | List all students | Easy | SELECT | Legacy coursework: academic-management BTL |
| [P018](./018-scholarship-over-five-million/) | Scholarship over five million | Easy | WHERE | Legacy coursework: academic-management BTL |
| [P019](./019-count-students-by-class/) | Count students by class | Easy | GROUP BY, COUNT | Legacy coursework: academic-management BTL |
| [P020](./020-total-subject-hours/) | Total subject hours | Easy | expression | Legacy coursework: academic-management BTL |
| [P021](./021-highest-score-per-student/) | Highest score per student | Easy | MAX, GROUP BY | Legacy coursework: academic-management BTL |
| [P022](./022-total-recorded-score-per-student/) | Total recorded score per student | Easy | SUM | Legacy coursework: academic-management BTL |
| [P023](./023-student-and-class-name/) | Student and class name | Easy | JOIN | Legacy coursework: academic-management BTL |
| [P024](./024-nguyen-students-from-hanoi/) | Nguyen students from Hanoi | Easy | JOIN, LIKE | Legacy coursework: academic-management BTL |
| [P025](./025-teachers-and-taught-subjects/) | Teachers and taught subjects | Easy | multi-join | Legacy coursework: academic-management BTL |
| [P026](./026-students-by-ethnicity/) | Students by ethnicity | Easy | LEFT JOIN, GROUP BY | Legacy coursework: academic-management BTL |
| [P027](./027-average-score-per-student/) | Average score per student | Easy | AVG | Legacy coursework: academic-management BTL |
| [P028](./028-average-score-above-eight/) | Average score above eight | Easy | HAVING | Legacy coursework: academic-management BTL |
| [P029](./029-sort-by-average-score/) | Sort by average score | Easy | ORDER BY, AVG | Legacy coursework: academic-management BTL |
| [P030](./030-students-by-religion/) | Students by religion | Easy | LEFT JOIN, COUNT | Legacy coursework: academic-management BTL |
| [P031](./031-lowest-score-by-attempt-number/) | Lowest score by attempt number | Easy | MIN, GROUP BY | Legacy coursework: academic-management BTL |
| [P032](./032-student-class-and-homeroom-teacher/) | Student class and homeroom teacher | Easy | JOIN | Legacy coursework: academic-management BTL |
| [P033](./033-teachers-with-more-than-two-subjects/) | Teachers with more than two subjects | Medium | COUNT DISTINCT, HAVING | Legacy coursework: academic-management BTL |
| [P034](./034-non-kinh-students/) | Non-Kinh students | Easy | JOIN, inequality | Legacy coursework: academic-management BTL |
| [P035](./035-failed-first-attempts/) | Failed first attempts | Easy | WHERE | Legacy coursework: academic-management BTL |
| [P036](./036-hometown-then-average-ranking/) | Hometown then average ranking | Medium | JOIN, AVG, ORDER BY | Legacy coursework: academic-management BTL |
| [P037](./037-average-score-function/) | Average-score function | Medium | scalar UDF | Legacy coursework: academic-management BTL |
| [P038](./038-completed-subject-count-function/) | Completed-subject count function | Hard | UDF, window function | Legacy coursework: academic-management BTL |
| [P039](./039-highest-score-function/) | Highest-score function | Medium | scalar UDF | Legacy coursework: academic-management BTL |
| [P040](./040-accurate-age-function/) | Accurate age function | Medium | date arithmetic, UDF | Legacy coursework: academic-management BTL |
| [P041](./041-passed-all-function/) | Passed-all function | Hard | UDF, NOT EXISTS, window | Legacy coursework: academic-management BTL |
| [P042](./042-insert-student-procedure/) | Insert student procedure | Easy | procedure, DML | Legacy coursework: academic-management BTL |
| [P043](./043-update-student-procedure/) | Update student procedure | Easy | procedure, UPDATE | Legacy coursework: academic-management BTL |
| [P044](./044-delete-student-procedure/) | Delete student procedure | Medium | procedure, DELETE | Legacy coursework: academic-management BTL |
| [P045](./045-insert-subject-procedure/) | Insert subject procedure | Easy | procedure | Legacy coursework: academic-management BTL |
| [P046](./046-update-exam-result-procedure/) | Update exam result procedure | Easy | procedure | Legacy coursework: academic-management BTL |
| [P047](./047-insert-teacher-procedure/) | Insert teacher procedure | Easy | procedure | Legacy coursework: academic-management BTL |
| [P048](./048-assign-a-subject-procedure/) | Assign a subject procedure | Easy | procedure | Legacy coursework: academic-management BTL |
| [P049](./049-scholarship-validation-trigger/) | Scholarship validation trigger | Medium | trigger, multi-row | Legacy coursework: academic-management BTL |
| [P050](./050-course-hours-audit-trigger/) | Course-hours audit trigger | Medium | trigger, inserted/deleted | Legacy coursework: academic-management BTL |
| [P051](./051-cascade-grade-deletion-trigger/) | Cascade grade deletion trigger | Medium | INSTEAD OF trigger | Legacy coursework: academic-management BTL |
| [P052](./052-current-average-from-latest-attempts/) | Current average from latest attempts | Hard | ROW_NUMBER, CTE | Advanced extension |
| [P053](./053-count-completed-assignments-correctly/) | Count completed assignments correctly | Hard | ROW_NUMBER, COUNT | Advanced extension |
| [P054](./054-top-three-students-per-class/) | Top three students per class | Hard | DENSE_RANK, partition | Advanced extension |
| [P055](./055-overall-student-ranking/) | Overall student ranking | Medium | window ranking | Advanced extension |
| [P056](./056-running-academic-average/) | Running academic average | Hard | window frame | Advanced extension |
| [P057](./057-above-class-average/) | Above class average | Hard | window aggregate | Advanced extension |
| [P058](./058-passed-every-class-assignment/) | Passed every class assignment | Hard | relational division, NOT EXISTS | Advanced extension |
| [P059](./059-teachers-with-no-assignment/) | Teachers with no assignment | Easy | anti-join | Advanced extension |
| [P060](./060-detect-duplicate-e-mails/) | Detect duplicate e-mails | Easy | GROUP BY, HAVING | Advanced extension |
| [P061](./061-cross-table-grade-integrity-audit/) | Cross-table grade integrity audit | Hard | joins, data quality | Advanced extension |
| [P062](./062-race-safe-grade-upsert/) | Race-safe grade upsert | Hard | transaction, locking | Advanced extension |
| [P063](./063-savepoint-rollback/) | Savepoint rollback | Hard | SAVE TRAN, TRY/CATCH | Advanced extension |
| [P064](./064-isolation-level-lab/) | Isolation-level lab | Hard | ACID, isolation | Advanced extension |
| [P065](./065-optimistic-concurrency-with-rowversion/) | Optimistic concurrency with rowversion | Hard | rowversion | Advanced extension |
| [P066](./066-covering-index-for-class-lookup/) | Covering index for class lookup | Hard | index, INCLUDE | Advanced extension |
| [P067](./067-filtered-index-for-failed-exams/) | Filtered index for failed exams | Hard | filtered index | Advanced extension |
| [P068](./068-sargable-adult-filter/) | SARGable adult filter | Medium | SARGability, date | Advanced extension |
| [P069](./069-keyset-pagination/) | Keyset pagination | Medium | pagination, index | Advanced extension |
| [P070](./070-multi-row-student-audit/) | Multi-row student audit | Hard | trigger, audit | Advanced extension |
| [P071](./071-soft-delete-students/) | Soft delete students | Medium | soft delete | Advanced extension |
| [P072](./072-idempotent-seed-script/) | Idempotent seed script | Medium | deployment, idempotency | Advanced extension |
| [P073](./073-deadlock-prevention-order/) | Deadlock prevention order | Hard | locking, deadlock | Advanced extension |
| [P074](./074-transaction-error-handling/) | Transaction error handling | Hard | TRY/CATCH, XACT_STATE | Advanced extension |
| [P075](./075-score-improvement-with-lag/) | Score improvement with LAG | Medium | LAG, window | Advanced extension |
| [P076](./076-pivot-grade-report/) | Pivot grade report | Hard | PIVOT | Advanced extension |
| [P077](./077-multi-level-summaries/) | Multi-level summaries | Hard | GROUPING SETS | Advanced extension |
| [P078](./078-json-export-and-import-projection/) | JSON export and import projection | Medium | FOR JSON, OPENJSON | Advanced extension |
| [P079](./079-optional-filter-search/) | Optional-filter search | Hard | procedure, parameter sensitivity | Advanced extension |
| [P080](./080-recursive-prerequisites/) | Recursive prerequisites | Hard | recursive CTE | Advanced extension |
| [P081](./081-normalize-address-data/) | Normalize address data | Medium | 3NF, modeling | Advanced extension |
| [P082](./082-bcnf-decomposition/) | BCNF decomposition | Hard | BCNF, FD | Advanced extension |
| [P083](./083-lossless-join-vs-dependency-preservation/) | Lossless join vs dependency preservation | Hard | normalization theory | Advanced extension |
| [P084](./084-composite-vs-surrogate-keys/) | Composite vs surrogate keys | Medium | schema design | Advanced extension |
| [P085](./085-cascade-delete-decision/) | Cascade delete decision | Medium | referential actions | Advanced extension |
| [P086](./086-least-privilege-role/) | Least-privilege role | Medium | GRANT, DENY | Advanced extension |
| [P087](./087-row-level-security-by-class/) | Row-level security by class | Hard | RLS, security policy | Advanced extension |
| [P088](./088-temporal-student-history/) | Temporal student history | Hard | temporal table | Advanced extension |
| [P089](./089-indexed-view-for-class-counts/) | Indexed view for class counts | Hard | indexed view | Advanced extension |
| [P090](./090-columnstore-analytics-index/) | Columnstore analytics index | Hard | columnstore | Advanced extension |
| [P091](./091-sequence-based-identifiers/) | Sequence-based identifiers | Medium | SEQUENCE, concurrency | Advanced extension |
| [P092](./092-set-based-grade-validation-trigger/) | Set-based grade validation trigger | Hard | trigger, multi-row | Advanced extension |
| [P093](./093-not-exists-vs-not-in/) | NOT EXISTS vs NOT IN | Medium | NULL, anti-join | Advanced extension |
| [P094](./094-distinct-vs-group-by/) | DISTINCT vs GROUP BY | Easy | deduplication, aggregation | Advanced extension |
| [P095](./095-where-vs-having/) | WHERE vs HAVING | Easy | aggregation | Advanced extension |
| [P096](./096-union-vs-union-all/) | UNION vs UNION ALL | Easy | set operator | Advanced extension |
| [P097](./097-exists-vs-join/) | EXISTS vs JOIN | Medium | semi-join | Advanced extension |
| [P098](./098-cte-vs-temp-table/) | CTE vs temp table | Hard | materialization, tempdb | Advanced extension |
| [P099](./099-composite-index-column-order/) | Composite index column order | Hard | index design | Advanced extension |
| [P100](./100-capstone-academic-transcript/) | Capstone academic transcript | Hard | CTE, window, aggregation | Advanced extension |
