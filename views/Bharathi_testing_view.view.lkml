view: bharathi_testing_view {
    sql_table_name: Samplestore_data.Bharathi_salestable ;;

    dimension: row_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.Row ID ;;
    }

    dimension: order_id {
      type: string
      sql: ${TABLE}.Order ID ;;
    }

    dimension: order_date {
      type: date
      #sql: PARSE_DATE('%m/%d/%Y', ${TABLE}.Order Date) ;;
      sql: DATE(${TABLE}.order_date) ;;
      }


    dimension: ship_date {
      type: date
      sql: PARSE_DATE('%m/%d/%Y', ${TABLE}.Ship Date) ;;
    }

    dimension: ship_mode {
      type: string
      sql: ${TABLE}.Ship Mode ;;
    }

    dimension: customer_id {
      type: string
      sql: ${TABLE}.Customer ID ;;
    }

    dimension: customer_name {
      type: string
      #sql: ${TABLE}.Customer Name ;;
      sql: LOWER(${TABLE}.customer_name) ;;
    }

    dimension: segment {
      type: string
      sql: ${TABLE}.Segment ;;
    }

    dimension: country {
      type: string
      sql: ${TABLE}.Country ;;
    }

    dimension: city {
      type: string
      sql: ${TABLE}.City ;;
    }

    dimension: postal_code {
      type: string
      sql: ${TABLE}.Postal Code ;;
    }

    dimension: region {
      type: string
      sql: ${TABLE}.Region ;;
    }

    dimension: product_id {
      type: string
      sql: ${TABLE}.Product ID ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}.Category ;;
    }

    dimension: sub_category {
      type: string
      sql: ${TABLE}.Sub-Category ;;
    }

    dimension: product_name {
      type: string
      sql: ${TABLE}.Product Name ;;
    }

    dimension: sales {
      type: number
      sql: ${TABLE}.Sales ;;
    }
    measure: total_sales {
      type: sum
      sql:  ${sales} ;;
    }

    dimension: quantity {
      type: number
      sql: ${TABLE}.Quantity ;;
    }

    dimension: discount {
      type: number
      sql: ${TABLE}.Discount ;;
    }

    dimension: profit {
      type: number
      sql: COALESCE(${TABLE}.profit, 0) ;;
    }
  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }
  dimension: profit_ratio {
    type: number
    sql: ${profit} / ${sales} ;;
  }
  measure: sales_per_customer {
    type: number
    sql: ${total_sales} / COUNT(DISTINCT ${customer_id}) ;;
  }
  dimension: days_to_ship {
    type: number
    sql: DATE_DIFF(${ship_date}, ${order_date}) ;;
  }
  dimension: order_year {
    type: number
    sql: EXTRACT(YEAR FROM ${order_date}) ;;
  }
  dimension: order_quarter {
    type: number
    sql: EXTRACT(QUARTER FROM ${order_date}) ;;
  }

  dimension: order_month {
    type: number
    sql: EXTRACT(MONTH FROM ${order_date}) ;;
  }
  dimension: clv_segment {
    type: string
    sql:
      CASE
        WHEN SUM(${sales}) >= 10000 THEN 'High'
        WHEN SUM(${sales}) BETWEEN 5000 AND 9999 THEN 'Medium'
        ELSE 'Low'
      END ;;
  }


  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: bharathi_testing_view {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
